#include "direntries.h"

#include "core.h"
#include "dal.h"
#include "fileblocks.h"
#include "direntries.h"
#include "bin_direntries.h"

#include <errno.h>
#include <string.h>
#include <libgen.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>

namespace sofs19
{
    static int traverseValidPath(char* path, char* current_path, int inode);

    uint32_t grpTraversePath(char *path)
    {
        soProbe(221, "%s(%s)\n", __FUNCTION__, path);

        /* change the following line by your code */

        if (strcmp(strndupa(path,1),"/")) {
            throw SOException(EINVAL, __FUNCTION__);
        }

        return traverseValidPath(path, (char*) "/", 0);
    }

    static int traverseValidPath(char* path, char* current_path, int inode) {

        if (inode == -1) {
            throw SOException(ENOENT, __FUNCTION__);
        }

        if (!strcmp(path,current_path)) {
            return inode;
        }

        char* tmp_path = strdupa(path);         // duplicate path for traversal
        char* name = strdupa(path);
        int ih = soOpenInode(inode);
        // get the
        while (strcmp(dirname(tmp_path),current_path)) {
            name = strdupa(tmp_path);
        }

        SOInode* in_ptr = soGetInodePointer(ih);
        if (!S_ISDIR(in_ptr->mode)) {
            throw SOException(ENOTDIR, __FUNCTION__);
        }

        if ((in_ptr->owner == getuid() or in_ptr->group == getgid()) and soCheckInodeAccess(inode, X_OK)) {
            return traverseValidPath(path, name,soGetDirEntry(ih,basename(strdupa(name))));
        }
        else {
            throw SOException(EACCES, __FUNCTION__);
        }
    }
};

