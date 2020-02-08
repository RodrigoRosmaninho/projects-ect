/*
 *  \authur Artur Pereira - 2009-2019
 */

#include "freelists.h"
#include "bin_freelists.h"
#include "grp_freelists.h"

#include "core.h"

namespace sofs19
{

    void soDepleteTailCache(void)
    {
        if (soBinSelected(444))
            binDepleteTailCache();
        else
            grpDepleteTailCache();
    }

};
