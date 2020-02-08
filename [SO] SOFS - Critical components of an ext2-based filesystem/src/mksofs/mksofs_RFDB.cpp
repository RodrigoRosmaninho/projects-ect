/*
 *  \authur Artur Pereira - 2009-2019
 */

#include "mksofs.h"
#include "bin_mksofs.h"
#include "grp_mksofs.h"

#include "core.h"

#include <inttypes.h>

namespace sofs19
{
    /* see mksofs.h for a description */
    void soResetFreeDataBlocks(uint32_t ntotal, uint32_t itotal, uint32_t nbref)
    {
        if (soBinSelected(607))
            binResetFreeDataBlocks(ntotal, itotal, nbref);
        else
            grpResetFreeDataBlocks(ntotal, itotal, nbref);
    }

};
