/* Public Domain [mini] c runtime library replacements for Win32 
 * KJD <jeremyd@computer.org>
 */

#include "miniclib.h"

int errno = ESUCCESS;

FILE *stdin=NULL, *stdout=NULL, *stderr=NULL;

#define setStdFileHnd(f,h) \
	f = (FILE *)malloc(sizeof(FILE));	\
	if (f != NULL)						\
	{									\
		f->handle = GetStdHandle(h);	\
		f->eof = 0;						\
		f->err = 0;						\
	}

/* you must call this before using any other function!!! */
void mCRTinit(void)
{
	setStdFileHnd(stdin, STD_INPUT_HANDLE);
	setStdFileHnd(stdout, STD_OUTPUT_HANDLE);
	setStdFileHnd(stderr, STD_ERROR_HANDLE);
}


void * malloc(size_t size)
{
  return HeapAlloc(GetProcessHeap(), 0, size);
}

void * calloc(size_t num, size_t size)
{
  return HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, num*size);
}

void free(void *ptr)
{
  HeapFree(GetProcessHeap(), 0, ptr);
}

void * realloc(void *ptr, size_t size)
{
  if (ptr == NULL) return malloc(size);
    
  if (!size)
  {
    free(ptr);
    return NULL;
  }
  else
    return HeapReAlloc( GetProcessHeap(), 0, ptr, size );
}


char * strdup(const char *str)
{
  char *t = (char *)malloc(strlen(str)+1);
  if (t != NULL) strcpy(t, str);
  return t;
}

char * strrchr(const char *str, int c)
{
	const char *t = str + strlen(str);  /* assumes str is '\0' terminated */
	while (t >=  str)
	{
		if (*t == (char)c) return (char *)t;
		t--;
	}

	return NULL;
}

/* memmove,memcpy,memset,&memcmp from Paul Edwards public domain clib */
void * memmove(void *s1, const void *s2, size_t n)
{
    char *p = s1;
    const char *cs2 = s2;
    size_t x;
    
    if (p <= cs2)
    {
        for (x=0; x < n; x++)
        {
            *p = *cs2;
            p++;
            cs2++;
        }
    }
    else
    {
        if (n != 0)
        {
            for (x=n-1; x > 0; x--)
            {
                *(p+x) = *(cs2+x);
            }
        }
        *(p+x) = *(cs2+x);
    }
    return (s1);
}

// MSVC [6&7] Professional+ these are intrinsic
// and this causes a duplicate function error,
// but on Standard they are not intrinsic or if
// forced as functions then these are needed.
#ifdef NO_INTRINSIC_MEMFUNCS
void *memcpy(void *s1, const void *s2, size_t n)
{
    register unsigned int *p = (unsigned int *)s1;
    register unsigned int *cs2 = (unsigned int *)s2;
    register unsigned int *endi;
    
    endi = (unsigned int *)((char *)p + (n & ~0x03));
    while (p != endi)
    {
        *p++ = *cs2++;
    }
    switch (n & 0x03)
    {
        case 0:
            break;
        case 1:
            *(char *)p = *(char *)cs2;
            break;
        case 2:
            *(char *)p = *(char *)cs2;
            p = (unsigned int *)((char *)p + 1);
            cs2 = (unsigned int *)((char *)cs2 + 1);
            *(char *)p = *(char *)cs2;
            break;
        case 3:
            *(char *)p = *(char *)cs2;
            p = (unsigned int *)((char *)p + 1);
            cs2 = (unsigned int *)((char *)cs2 + 1);
            *(char *)p = *(char *)cs2;
            p = (unsigned int *)((char *)p + 1);
            cs2 = (unsigned int *)((char *)cs2 + 1);
            *(char *)p = *(char *)cs2;
            break;
    }
    return (s1);
}

void *memset(void *s, int c, size_t n)
{
    size_t x = 0;
    
    for (x = 0; x < n; x++)
    {
        *((char *)s + x) = (unsigned char)c;
    }
    return (s);
}

int memcmp(const void *s1, const void *s2, size_t n)
{
    const unsigned char *p1;
    const unsigned char *p2;
    size_t x = 0;
    
    p1 = (const unsigned char *)s1;
    p2 = (const unsigned char *)s2;
    while (x < n)
    {
        if (p1[x] < p2[x]) return (-1);
        else if (p1[x] > p2[x]) return (1);
        x++;
    }
    return (0);
}
#endif


/* fopen, only r[b],w[b],r[b]+,w[b]+ supported, that is a (append is not) */
FILE * fopen(const char *filename, const char *mode)
{
  DWORD dwAccess, dwCreate;
  FILE *f;

  if (strrchr(mode, 'r') != NULL)
  {
    dwAccess = GENERIC_READ;
    dwCreate = OPEN_EXISTING;
    if (strrchr(mode, '+') != NULL)
      dwAccess |= GENERIC_WRITE;
  }
  else if (strrchr(mode, 'w') != NULL)
  {
    dwAccess = GENERIC_WRITE;
    dwCreate = CREATE_ALWAYS;
    if (strrchr(mode, '+') != NULL)
      dwAccess |= GENERIC_READ;
  }
  else /* unknown mode */
  {
    errno = EINVAL;
    return NULL;
  }

  f = (FILE *)malloc(sizeof(FILE));
  if (f == NULL)
  {
    errno = ENOMEM;
    return NULL;
  }

  /* initialize all values here */
  f->eof = 0;
  f->err = 0;

  f->handle = CreateFileA(filename,dwAccess,FILE_SHARE_READ,NULL,dwCreate,FILE_ATTRIBUTE_NORMAL,NULL);
  if (f->handle == INVALID_HANDLE_VALUE)
  {
    switch (GetLastError())
    {
      case ERROR_ALREADY_EXISTS :
        errno = EEXIST;
        break;
      default:
        errno = EACCES;
        break;
    }
    free(f);
    f = NULL;
  }

  return f;
}

size_t fwrite(const void *buffer, long size, long count, FILE *f)
{
  unsigned long bytes_written;
  if (!size || !count) return 0;
  if (!WriteFile(f->handle,(LPVOID)buffer,size*count,&bytes_written,NULL))
    f->err = 1;
  return (size_t)(bytes_written/size); /* returns items written, not bytes written */
}

long fread(const void *buffer, long size, long count, FILE *f)
{
  unsigned long bytes_read;
  if (!size || !count) return 0;
  if (!ReadFile(f->handle,(LPVOID)buffer,size*count,&bytes_read,NULL))
    f->err = 1;
  else
    if (bytes_read == 0) f->eof = 1;
  return bytes_read/size;  /* returns items read, not bytes read */
}

int fclose(FILE *f)
{
  int retvalue = 0;
  if (f != NULL)
  {
    if (f->handle != INVALID_HANDLE_VALUE)
      retvalue = !CloseHandle(f->handle);
    free(f);      
  }
  return retvalue;
}

int fprintf(FILE *f, const char *format, ...)
{
  char buf[1024];
  va_list argptr;
  va_start(argptr, format);
  wvsprintfA (buf, format, argptr);
  va_end(argptr);
  return fwrite(buf,1,strlen(buf)+1,f);
}

int sprintf(char *buf, const char *format, ...)
{
  int retval;
  va_list argptr;
  va_start(argptr, format);
  retval = wvsprintfA (buf, format, argptr);
  va_end(argptr);
  return retval;
}

int fputc(int c, FILE *f)
{
  char buffer = (char)c;
  if (!fwrite(&buffer, 1, 1, f))
    return -1;
  else
    return c;
}


DWORD map_origin[3] = { FILE_BEGIN, FILE_CURRENT, FILE_END };

int fseek(FILE *f, long offset, int origin)
{
  if (SetFilePointer(f->handle, offset, 0, map_origin[origin]) != 0xFFFFFFFF)
	  return 0;
  else
	  return -1;
}

long ftell(FILE *f)
{
  return SetFilePointer(f->handle, 0, 0, FILE_CURRENT);
}

void rewind(FILE *f)
{
  fseek(f, 0L, SEEK_SET);
  f->eof = 0;
  f->err = 0;
}

int fflush(FILE *f)
{
  /* nothing really to flush, so do nothing and return ok */
  return 0;
}

FILE *_fdopen(int handle, const char *mode)
{
  /* TODO */
  return NULL;
}


#ifdef UNICODE
unsigned char staticCnvBuffer[1024*sizeof(TCHAR)]; /* temp buffer, holds ASCII & UNICODE string after conversion */
char * _T2A(unsigned short *wideStr)
{
	WideCharToMultiByte(CP_ACP, 0, wideStr, -1, staticCnvBuffer, sizeof(staticCnvBuffer), NULL, NULL);
	return (char *)staticCnvBuffer;
}

unsigned short * _A2T(char *ansiStr)
{
	MultiByteToWideChar(CP_ACP, 0, ansiStr, -1, (TCHAR *)staticCnvBuffer, sizeof(staticCnvBuffer)/sizeof(TCHAR));
	return (unsigned short *)staticCnvBuffer;
}
#endif
