/*
 *  \author Artur Pereira - 2016-2019
 */

#include "bin_syscalls.h"
#include "core.h"

namespace sofs19
{
    int soRmdir(const char *path)
    {
        if (soBinSelected(106))
            return binRmdir(path);
        else
            /* replace prefix bin with grp if you implement this syscall */
            return binRmdir(path);
    }

};
