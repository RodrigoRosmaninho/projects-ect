/*
 *  \author António Rui Borges - 2012-2015
 *  \authur Artur Pereira - 2009-2019
 */

#include "grp_freelists.h"

#include <stdio.h>
#include <errno.h>
#include <inttypes.h>
#include <time.h>
#include <unistd.h>
#include <sys/types.h>

#include "core.h"
#include "dal.h"
#include "freelists.h"
#include "bin_freelists.h"

namespace sofs19 {
    uint32_t grpAllocDataBlock() {
        soProbe(441, "%s()\n", __FUNCTION__);

        SOSuperBlock* s = soGetSuperBlockPointer();
        if (s -> head_cache.idx == HEAD_CACHE_SIZE){
            soReplenishHeadCache();
        }

        uint32_t block=s -> head_cache.ref[s -> head_cache.idx];
        s -> head_cache.ref[s -> head_cache.idx] = NullReference;
        s -> dz_free -= 1;
        s -> head_cache.idx += 1;

        soSaveSuperBlock();
        return block;
    }
};
