typedef void (*GLADapiproc)(void);

typedef GLADapiproc (*GLADloadfunc)(const char *name);

int gladLoadGL( GLADloadfunc load);