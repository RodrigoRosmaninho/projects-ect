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
    void soFillRootDir(uint32_t itotal)
    {
        if (soBinSelected(606))
            return binFillRootDir(itotal);
        else
            return grpFillRootDir(itotal);
    }

};
