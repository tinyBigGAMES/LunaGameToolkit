#define Z_ERRNO -1
#define Z_OK 0
#define Z_DEFLATED 8
#define Z_DEFAULT_STRATEGY 0

#define ZIP_OK                          (0)
#define ZIP_EOF                         (0)
#define ZIP_ERRNO                       (Z_ERRNO)
#define ZIP_PARAMERROR                  (-102)
#define ZIP_BADZIPFILE                  (-103)
#define ZIP_INTERNALERROR               (-104)

#define UNZ_OK                          (0)
#define UNZ_END_OF_LIST_OF_FILE         (-100)
#define UNZ_ERRNO                       (Z_ERRNO)
#define UNZ_EOF                         (0)
#define UNZ_PARAMERROR                  (-102)
#define UNZ_BADZIPFILE                  (-103)
#define UNZ_INTERNALERROR               (-104)
#define UNZ_CRCERROR                    (-105)

#define ZPOS64_T uint64_t
#define z_off_t long

#define APPEND_STATUS_CREATE        (0)
#define APPEND_STATUS_CREATEAFTER   (1)
#define APPEND_STATUS_ADDINZIP      (2)

typedef void *voidp;
typedef voidp unzFile;
typedef voidp zipFile;
typedef unsigned int   uInt;  /* 16 bits or more */
typedef unsigned long  uLong;
typedef unsigned char  Byte;
typedef Byte Bytef;

typedef struct tm_zip_s
{
    int tm_sec;             /* seconds after the minute - [0,59] */
    int tm_min;             /* minutes after the hour - [0,59] */
    int tm_hour;            /* hours since midnight - [0,23] */
    int tm_mday;            /* day of the month - [1,31] */
    int tm_mon;             /* months since January - [0,11] */
    int tm_year;            /* years - [1980..2044] */
} tm_zip;

typedef struct
{
    tm_zip      tmz_date;       /* date in understandable format           */
    uLong       dosDate;       /* if dos_date == 0, tmu_date is used      */
/*    uLong       flag;        */   /* general purpose bit flag        2 bytes */

    uLong       internal_fa;    /* internal file attributes        2 bytes */
    uLong       external_fa;    /* external file attributes        4 bytes */
} zip_fileinfo;

typedef struct tm_unz_s
{
    int tm_sec;             /* seconds after the minute - [0,59] */
    int tm_min;             /* minutes after the hour - [0,59] */
    int tm_hour;            /* hours since midnight - [0,23] */
    int tm_mday;            /* day of the month - [1,31] */
    int tm_mon;             /* months since January - [0,11] */
    int tm_year;            /* years - [1980..2044] */
} tm_unz;

typedef struct unz_file_info64_s
{
    uLong version;              /* version made by                 2 bytes */
    uLong version_needed;       /* version needed to extract       2 bytes */
    uLong flag;                 /* general purpose bit flag        2 bytes */
    uLong compression_method;   /* compression method              2 bytes */
    uLong dosDate;              /* last mod file date in Dos fmt   4 bytes */
    uLong crc;                  /* crc-32                          4 bytes */
    ZPOS64_T compressed_size;   /* compressed size                 8 bytes */
    ZPOS64_T uncompressed_size; /* uncompressed size               8 bytes */
    uLong size_filename;        /* filename length                 2 bytes */
    uLong size_file_extra;      /* extra field length              2 bytes */
    uLong size_file_comment;    /* file comment length             2 bytes */

    uLong disk_num_start;       /* disk number start               2 bytes */
    uLong internal_fa;          /* internal file attributes        2 bytes */
    uLong external_fa;          /* external file attributes        4 bytes */

    tm_unz tmu_date;
} unz_file_info64;

extern uLong crc32(uLong crc, const Bytef *buf, uInt len);
extern unzFile unzOpen64 (const void *path);
extern int unzLocateFile (unzFile file, const char *szFileName, int iCaseSensitivity);
extern int unzClose (unzFile file);
extern int unzOpenCurrentFilePassword (unzFile file, const char* password);
extern int unzGetCurrentFileInfo64 (unzFile file, unz_file_info64 *pfile_info, char *szFileName, uLong fileNameBufferSize, void *extraField, uLong extraFieldBufferSize, char *szComment, uLong commentBufferSize);
extern int unzReadCurrentFile (unzFile file, voidp buf, unsigned len);
extern int unzCloseCurrentFile (unzFile file);
extern ZPOS64_T unztell64 (unzFile file);
extern zipFile zipOpen64 (const void *pathname, int append);
extern int zipOpenNewFileInZip3_64 (zipFile file, const char* filename,
  const zip_fileinfo* zipfi, const void* extrafield_local,
  uInt size_extrafield_local, const void* extrafield_global,
  uInt size_extrafield_global, const char* comment, int method, int level,
  int raw, int windowBits, int memLevel, int strategy, const char* password,
  uLong crcForCrypting, int zip64);
extern int zipWriteInFileInZip (zipFile file, const void* buf, unsigned len);  
extern int zipCloseFileInZip (zipFile file);
extern int zipClose (zipFile file, const char* global_comment);
