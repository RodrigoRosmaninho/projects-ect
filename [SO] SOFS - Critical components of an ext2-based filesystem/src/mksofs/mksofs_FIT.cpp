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
    void soFillInodeTable(uint32_t itotal, bool set_date)
    {
        if (soBinSelected(604))
            return binFillInodeTable(itotal, set_date);
        else
            return grpFillInodeTable(itotal, set_date);
    }

};
