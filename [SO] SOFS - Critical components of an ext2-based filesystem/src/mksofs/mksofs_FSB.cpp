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
    void soFillSuperBlock(const char *name, uint32_t ntotal, uint32_t itotal, uint32_t nbref)
    {
        if (soBinSelected(602))
            binFillSuperBlock(name, ntotal, itotal, nbref);
        else
            grpFillSuperBlock(name, ntotal, itotal, nbref);
    }

};
