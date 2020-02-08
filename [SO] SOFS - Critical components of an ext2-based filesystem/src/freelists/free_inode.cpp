/*
 *  \authur Artur Pereira - 2009-2019
 */

#include "freelists.h"
#include "bin_freelists.h"
#include "grp_freelists.h"

#include "core.h"

namespace sofs19
{

    void soFreeInode(uint32_t in)
    {
        if (soBinSelected(402))
            binFreeInode(in);
        else
            grpFreeInode(in);
    }

};
