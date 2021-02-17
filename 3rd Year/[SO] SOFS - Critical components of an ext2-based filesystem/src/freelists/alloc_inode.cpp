/*
 *  \authur Artur Pereira - 2009-2019
 */

#include "freelists.h"
#include "bin_freelists.h"
#include "grp_freelists.h"

#include "core.h"

namespace sofs19
{

    uint32_t soAllocInode(uint32_t type, uint32_t perm)
    {
        if (soBinSelected(401))
            return binAllocInode(type, perm);
        else
            return grpAllocInode(type, perm);
    }

};
