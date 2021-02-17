/*
 *  \author Artur Pereira - 2016-2019
 */

#include "bin_syscalls.h"
#include "core.h"

namespace sofs19
{
    int soReadlink(const char *path, char *buf, size_t bufsz)
    {
        if (soBinSelected(112))
            return binReadlink(path, buf, bufsz);
        else
            /* replace prefix bin with grp if you implement this syscall */
            return binReadlink(path, buf, bufsz);
    }

};
