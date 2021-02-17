/*
 *  \authur Artur Pereira - 2009-2019
 */

#include "freelists.h"
#include "bin_freelists.h"
#include "grp_freelists.h"

#include "core.h"

namespace sofs19
{

    uint32_t soAllocDataBlock()
    {
        if (soBinSelected(441))
            return binAllocDataBlock();
        else
            return grpAllocDataBlock();
    }

};
