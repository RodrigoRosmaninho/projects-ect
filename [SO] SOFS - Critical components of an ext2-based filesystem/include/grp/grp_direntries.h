/**
 *  \file 
 *  \brief Student version of the functions to manage directory entries
 *
 *  \author Artur Pereira 2008-2009, 2016-2019
 *
 *  \remarks See the main \c direntries header file for documentation
 */

#ifndef __SOFS19_DIRENTRIES_GROUP__
#define __SOFS19_DIRENTRIES_GROUP__

#include <inttypes.h>

namespace sofs19
{
    uint32_t grpTraversePath(char *path);

    uint32_t grpGetDirEntry(int pih, const char *name);

    void grpAddDirEntry(int pih, const char *name, uint32_t cin);

    uint32_t grpDeleteDirEntry(int pih, const char *name);

    void grpRenameDirEntry(int pih, const char *name, const char *newName);

    bool grpCheckDirEmpty(int ih);
};

#endif /* __SOFS19_DIRENTRIES_GROUP__ */
