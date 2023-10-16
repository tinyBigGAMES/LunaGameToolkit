#ifndef _OV_FILE_H_
#define _OV_FILE_H_

#ifdef __cplusplus
extern "C"
{
#endif /* __cplusplus */

#include <stdio.h>
#include <stdint.h>

typedef int16_t ogg_int16_t;
typedef uint16_t ogg_uint16_t;
typedef int32_t ogg_int32_t;
typedef uint32_t ogg_uint32_t;
typedef int64_t ogg_int64_t;
typedef uint64_t ogg_uint64_t;

typedef struct {
  unsigned char *data;
  int storage;
  int fill;
  int returned;

  int unsynced;
  int headerbytes;
  int bodybytes;
} ogg_sync_state;

typedef struct vorbis_info{
  int version;
  int channels;
  long rate;

  /* The below bitrate declarations are *hints*.
     Combinations of the three values carry the following implications:

     all three set to the same value:
       implies a fixed rate bitstream
     only nominal set:
       implies a VBR stream that averages the nominal bitrate.  No hard
       upper/lower limit
     upper and or lower set:
       implies a VBR bitstream that obeys the bitrate limits. nominal
       may also be set to give a nominal rate.
     none set:
       the coder does not care to speculate.
  */

  long bitrate_upper;
  long bitrate_nominal;
  long bitrate_lower;
  long bitrate_window;

  void *codec_setup;
} vorbis_info;

/* the comments are not part of vorbis_info so that vorbis_info can be
   static storage */
typedef struct vorbis_comment{
  /* unlimited user comment fields.  libvorbis writes 'libvorbis'
     whatever vendor is set to in encode */
  char **user_comments;
  int   *comment_lengths;
  int    comments;
  char  *vendor;

} vorbis_comment;

/* ogg_stream_state contains the current encode/decode state of a logical
   Ogg bitstream **********************************************************/

typedef struct {
  unsigned char   *body_data;    /* bytes from packet bodies */
  long    body_storage;          /* storage elements allocated */
  long    body_fill;             /* elements stored; fill mark */
  long    body_returned;         /* elements of fill returned */


  int     *lacing_vals;      /* The values that will go to the segment table */
  ogg_int64_t *granule_vals; /* granulepos values for headers. Not compact
                                this way, but it is simple coupled to the
                                lacing fifo */
  long    lacing_storage;
  long    lacing_fill;
  long    lacing_packet;
  long    lacing_returned;

  unsigned char    header[282];      /* working space for header encode */
  int              header_fill;

  int     e_o_s;          /* set when we have buffered the last packet in the
                             logical bitstream */
  int     b_o_s;          /* set after we've written the initial page
                             of a logical bitstream */
  long    serialno;
  long    pageno;
  ogg_int64_t  packetno;  /* sequence number for decode; the framing
                             knows where there's a hole in the data,
                             but we need coupling so that the codec
                             (which is in a separate abstraction
                             layer) also knows about the gap */
  ogg_int64_t   granulepos;

} ogg_stream_state;

/* vorbis_dsp_state buffers the current vorbis audio
   analysis/synthesis state.  The DSP state belongs to a specific
   logical bitstream ****************************************************/
typedef struct vorbis_dsp_state{
  int analysisp;
  vorbis_info *vi;

  float **pcm;
  float **pcmret;
  int      pcm_storage;
  int      pcm_current;
  int      pcm_returned;

  int  preextrapolate;
  int  eofflag;

  long lW;
  long W;
  long nW;
  long centerW;

  ogg_int64_t granulepos;
  ogg_int64_t sequence;

  ogg_int64_t glue_bits;
  ogg_int64_t time_bits;
  ogg_int64_t floor_bits;
  ogg_int64_t res_bits;

  void       *backend_state;
} vorbis_dsp_state;


typedef struct {
  long endbyte;
  int  endbit;

  unsigned char *buffer;
  unsigned char *ptr;
  long storage;
} oggpack_buffer;

typedef struct vorbis_block{
  /* necessary stream state for linking to the framing abstraction */
  float  **pcm;       /* this is a pointer into local storage */
  oggpack_buffer opb;

  long  lW;
  long  W;
  long  nW;
  int   pcmend;
  int   mode;

  int         eofflag;
  ogg_int64_t granulepos;
  ogg_int64_t sequence;
  vorbis_dsp_state *vd; /* For read-only access of configuration */

  /* local storage to avoid remallocing; it's up to the mapping to
     structure it */
  void               *localstore;
  long                localtop;
  long                localalloc;
  long                totaluse;
  struct alloc_chain *reap;

  /* bitmetrics for the frame */
  long glue_bits;
  long time_bits;
  long floor_bits;
  long res_bits;

  void *internal;

} vorbis_block;

/* The function prototypes for the callbacks are basically the same as for
 * the stdio functions fread, fseek, fclose, ftell.
 * The one difference is that the FILE * arguments have been replaced with
 * a void * - this is to be used as a pointer to whatever internal data these
 * functions might need. In the stdio case, it's just a FILE * cast to a void *
 *
 * If you use other functions, check the docs for these functions and return
 * the right values. For seek_func(), you *MUST* return -1 if the stream is
 * unseekable
 */
typedef struct {
  size_t (*read_func)  (void *ptr, size_t size, size_t nmemb, void *datasource);
  int    (*seek_func)  (void *datasource, ogg_int64_t offset, int whence);
  int    (*close_func) (void *datasource);
  long   (*tell_func)  (void *datasource);
} ov_callbacks;

#define  NOTOPEN   0
#define  PARTOPEN  1
#define  OPENED    2
#define  STREAMSET 3
#define  INITSET   4

typedef struct OggVorbis_File {
  void            *datasource; /* Pointer to a FILE *, etc. */
  int              seekable;
  ogg_int64_t      offset;
  ogg_int64_t      end;
  ogg_sync_state   oy;

  /* If the FILE handle isn't seekable (eg, a pipe), only the current
     stream appears */
  int              links;
  ogg_int64_t     *offsets;
  ogg_int64_t     *dataoffsets;
  long            *serialnos;
  ogg_int64_t     *pcmlengths; /* overloaded to maintain binary
                                  compatibility; x2 size, stores both
                                  beginning and end values */
  vorbis_info     *vi;
  vorbis_comment  *vc;

  /* Decoding working state local storage */
  ogg_int64_t      pcm_offset;
  int              ready_state;
  long             current_serialno;
  int              current_link;

  double           bittrack;
  double           samptrack;

  ogg_stream_state os; /* take physical pages, weld into a logical
                          stream of packets */
  vorbis_dsp_state vd; /* central working state for the packet->PCM decoder */
  vorbis_block     vb; /* local working space for packet->PCM decode */

  ov_callbacks callbacks;

} OggVorbis_File;


extern int ov_clear(OggVorbis_File *vf);
extern int ov_fopen(const char *path,OggVorbis_File *vf);
extern int ov_open_callbacks(void *datasource, OggVorbis_File *vf,
                const char *initial, long ibytes, ov_callbacks callbacks);

extern int ov_test_callbacks(void *datasource, OggVorbis_File *vf,
                const char *initial, long ibytes, ov_callbacks callbacks);
extern int ov_test_open(OggVorbis_File *vf);

extern long ov_bitrate(OggVorbis_File *vf,int i);
extern long ov_bitrate_instant(OggVorbis_File *vf);
extern long ov_streams(OggVorbis_File *vf);
extern long ov_seekable(OggVorbis_File *vf);
extern long ov_serialnumber(OggVorbis_File *vf,int i);

extern ogg_int64_t ov_raw_total(OggVorbis_File *vf,int i);
extern ogg_int64_t ov_pcm_total(OggVorbis_File *vf,int i);
extern double ov_time_total(OggVorbis_File *vf,int i);

extern int ov_raw_seek(OggVorbis_File *vf,ogg_int64_t pos);
extern int ov_pcm_seek(OggVorbis_File *vf,ogg_int64_t pos);
extern int ov_pcm_seek_page(OggVorbis_File *vf,ogg_int64_t pos);
extern int ov_time_seek(OggVorbis_File *vf,double pos);
extern int ov_time_seek_page(OggVorbis_File *vf,double pos);

extern int ov_raw_seek_lap(OggVorbis_File *vf,ogg_int64_t pos);
extern int ov_pcm_seek_lap(OggVorbis_File *vf,ogg_int64_t pos);
extern int ov_pcm_seek_page_lap(OggVorbis_File *vf,ogg_int64_t pos);
extern int ov_time_seek_lap(OggVorbis_File *vf,double pos);
extern int ov_time_seek_page_lap(OggVorbis_File *vf,double pos);

extern ogg_int64_t ov_raw_tell(OggVorbis_File *vf);
extern ogg_int64_t ov_pcm_tell(OggVorbis_File *vf);
extern double ov_time_tell(OggVorbis_File *vf);

extern vorbis_info *ov_info(OggVorbis_File *vf,int link);
extern vorbis_comment *ov_comment(OggVorbis_File *vf,int link);

extern long ov_read_float(OggVorbis_File *vf,float ***pcm_channels,int samples,
                          int *bitstream);
extern long ov_read_filter(OggVorbis_File *vf,char *buffer,int length,
                          int bigendianp,int word,int sgned,int *bitstream,
                          void (*filter)(float **pcm,long channels,long samples,void *filter_param),void *filter_param);
extern long ov_read(OggVorbis_File *vf,char *buffer,int length,
                    int bigendianp,int word,int sgned,int *bitstream);
extern int ov_crosslap(OggVorbis_File *vf1,OggVorbis_File *vf2);

extern int ov_halfrate(OggVorbis_File *vf,int flag);
extern int ov_halfrate_p(OggVorbis_File *vf);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif