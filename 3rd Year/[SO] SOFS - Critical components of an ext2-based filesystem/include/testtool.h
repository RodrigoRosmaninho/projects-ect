/**
 * 
 *
 * \defgroup testtool testtool
 * \ingroup tools
 * 
 * \brief The \b sofs19 intermediate functions test tool
 * 
 *      A menu driven test tool, allowing for testing the intermediate functions.
 */

/*
 *  \author Artur Pereira 2007-2009, 2016-2019
 *  \author Miguel Oliveira e Silva 2009, 2017
 *  \author António Rui Borges - 2010--2015
 *
 */


#ifndef __SOFS19_TESTTOOLS__
#define __SOFS19_TESTTOOLS__

#include <stdio.h>

extern const char *devname;

extern char *progDir;

extern int quiet;

/* msgs */
void promptMsg(const char *fmt, ...);
void resultMsg(const char *fmt, ...);
void errorMsg(const char *fmt, ...);
void errnoMsg(int en, const char *fmt, ...);
void fPurge(FILE * fin);

/* core */
void notImplemented();
void setProbeIDs();
void addProbeIDs();
void removeProbeIDs();
void printProbeIDs();
void createDisk();
void formatDisk();
void showBlock();
void setBinIDs();
void addBinIDs();
void removeBinIDs();
void printBinIDs();

/* freelists stuff */
void allocInode();
void freeInode();
void allocDataBlock();
void freeDataBlock();
void replenishHeadCache();
void depleteTailCache();

/* fileblocks */
void getFileBlock();
void allocFileBlock();
void freeFileBlocks();
void readFileBlock();
void writeFileBlock();

/* direntries */
void checkDirectoryEmptiness();
void getDirEntry();
void addDirEntry();
void renameDirEntry();
void deleteDirEntry();
void traversePath();

/* inodeattrs */
void setInodeSize();
void setInodeAccess();
void changeInodeOwnership();
void checkInodeAccess();
void decInodeLnkcnt();
void incInodeLnkcnt();

#endif /*  __SOFS19_TESTTOOLS__  */
