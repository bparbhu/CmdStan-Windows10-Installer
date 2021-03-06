# Microsoft Developer Studio Project File - Name="untgz" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=untgz - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "untgz.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "untgz.mak" CFG="untgz - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "untgz - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "untgz - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "untgz - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 1
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "UNTGZ_EXPORTS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /O1 /Ob2 /I "./zlib ..\..\..\source\zlib" /I "./zlib" /I "../../source/zlib" /D "NDEBUG" /D "_WIN32" /D "EXEHEAD" /D "WIN32" /D "_WINDOWS" /D "NSIS_COMPRESS_USE_ZLIB" /FAcs /FR /Gs32000 /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /win32
# SUBTRACT MTL /mktyplib203
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# SUBTRACT BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib comdlg32.lib advapi32.lib /nologo /dll /pdb:none /map /machine:I386 /nodefaultlib /out:"untgz.dll" /opt:nowin98 /ws:aggressive

!ELSEIF  "$(CFG)" == "untgz - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 1
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "UNTGZ_EXPORTS" /YX /FD /GZ /c
# ADD CPP /nologo /MD /W3 /Gm /ZI /Od /I "./zlib" /I "../../source/zlib" /D "_DEBUG" /D "_WIN32" /D "EXEHEAD" /D "WIN32" /D "_WINDOWS" /D "NSIS_COMPRESS_USE_ZLIB" /FR /Gs32000 /FD /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /win32
# SUBTRACT MTL /mktyplib203
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# SUBTRACT BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib comdlg32.lib advapi32.lib /nologo /dll /pdb:none /map /debug /machine:I386 /nodefaultlib

!ENDIF 

# Begin Target

# Name "untgz - Win32 Release"
# Name "untgz - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\zlib\adler32.c
# End Source File
# Begin Source File

SOURCE=.\bz2\blocksort.c
# End Source File
# Begin Source File

SOURCE=.\bz2\bzlib.c
# End Source File
# Begin Source File

SOURCE=.\zlib\crc32.c
# End Source File
# Begin Source File

SOURCE=.\bz2\crctable.c
# End Source File
# Begin Source File

SOURCE=.\bz2\decompress.c
# End Source File
# Begin Source File

SOURCE=.\filetype.cpp
# End Source File
# Begin Source File

SOURCE=.\zlib\gzio.c
# End Source File
# Begin Source File

SOURCE=.\bz2\huffman.c
# End Source File
# Begin Source File

SOURCE=.\zlib\inffast.c
# End Source File
# Begin Source File

SOURCE=.\zlib\inflate.c
# End Source File
# Begin Source File

SOURCE=.\zlib\inftrees.c
# End Source File
# Begin Source File

SOURCE=.\lzma\lzma.c
# End Source File
# Begin Source File

SOURCE=.\lzma\LzmaDecode.c
# End Source File
# Begin Source File

SOURCE=.\miniclib.c
# End Source File
# Begin Source File

SOURCE=.\nsisUtils.c
# End Source File
# Begin Source File

SOURCE=.\bz2\randtable.c
# End Source File
# Begin Source File

SOURCE=.\untar.c
# End Source File
# Begin Source File

SOURCE=.\untgz.cpp
# End Source File
# Begin Source File

SOURCE=.\zlib\zutil.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\bz2\bz2.h
# End Source File
# Begin Source File

SOURCE=.\bz2\bzlib_private.h
# End Source File
# Begin Source File

SOURCE=.\zlib\crc32.h
# End Source File
# Begin Source File

SOURCE=.\zlib\inffast.h
# End Source File
# Begin Source File

SOURCE=.\zlib\inffixed.h
# End Source File
# Begin Source File

SOURCE=.\zlib\inflate.h
# End Source File
# Begin Source File

SOURCE=.\zlib\inftrees.h
# End Source File
# Begin Source File

SOURCE=.\lzma\lzma.h
# End Source File
# Begin Source File

SOURCE=.\lzma\LzmaDecode.h
# End Source File
# Begin Source File

SOURCE=.\lzma\LzmaTypes.h
# End Source File
# Begin Source File

SOURCE=.\miniclib.h
# End Source File
# Begin Source File

SOURCE=.\nsisUtils.h
# End Source File
# Begin Source File

SOURCE=.\untar.h
# End Source File
# Begin Source File

SOURCE=.\zlib\zconf.h
# End Source File
# Begin Source File

SOURCE=.\zlib\zlib.h
# End Source File
# Begin Source File

SOURCE=.\zlib\zutil.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\untgz.rc
# End Source File
# End Group
# Begin Source File

SOURCE=.\LLMUL.OBJ
# End Source File
# End Target
# End Project
