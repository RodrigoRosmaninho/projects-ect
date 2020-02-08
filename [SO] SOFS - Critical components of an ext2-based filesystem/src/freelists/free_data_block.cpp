/*
 *  \authur Artur Pereira - 2009-2019
 */

#include "freelists.h"
#include "bin_freelists.h"
#include "grp_freelists.h"

#include "core.h"

namespace sofs19
{

    void soFreeDataBlock(uint32_t bn)
    {
        if (soBinSelected(442))
            binFreeDataBlock(bn);
        else
            grpFreeDataBlock(bn);
    }

};
