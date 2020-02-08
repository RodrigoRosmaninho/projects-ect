/**
 *  \file 
 *  \brief Binary version of functions to manage directories and directory entries
 *
 *  \author Artur Pereira 2008-2009, 2016-2019
 *  \author Miguel Oliveira e Silva 2009, 2017
 *  \author António Rui Borges - 2012-2015
 *
 */

#ifndef __SOFS19_DIRENTRIES_BIN__
#define __SOFS19_DIRENTRIES_BIN__

#include <inttypes.h>

namespace sofs19
{
    uint32_t binTraversePath(char *path);

    uint32_t binGetDirEntry(int pih, const char *name);

    void binAddDirEntry(int pih, const char *name, uint32_t cin);

    uint32_t binDeleteDirEntry(int pih, const char *name);

    void binRenameDirEntry(int pih, const char *name, const char *newName);

    bool binCheckDirEmpty(int ih);
};

#endif /* __SOFS19_DIRENTRIES_BIN__ */
