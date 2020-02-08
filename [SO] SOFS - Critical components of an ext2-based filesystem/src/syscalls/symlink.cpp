/*
 *  \author Artur Pereira - 2016-2019
 */

#include "bin_syscalls.h"
#include "core.h"

namespace sofs19
{
    int soSymlink(const char *effPath, const char *path)
    {
        if (soBinSelected(103))
            return binSymlink(effPath, path);
        else
            /* replace prefix bin with grp if you implement this syscall */
            return binSymlink(effPath, path);
    }

};
