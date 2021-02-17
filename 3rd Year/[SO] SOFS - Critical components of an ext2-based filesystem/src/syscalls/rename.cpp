/*
 *  \author Artur Pereira - 2016-2019
 */

#include "bin_syscalls.h"
#include "core.h"

namespace sofs19
{
    int soRename(const char *path, const char *newPath)
    {
        if (soBinSelected(107))
            return binRename(path, newPath);
        else
            /* replace prefix bin with grp if you implement this syscall */
            return binRename(path, newPath);
    }

};
