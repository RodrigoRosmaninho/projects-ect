/*
 *  \author António Rui Borges - 2012-2015
 *  \authur Artur Pereira - 2016-2019
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

namespace sofs19
{
    void grpFreeDataBlock(uint32_t bn)
    {
        soProbe(442, "%s(%u)\n", __FUNCTION__, bn);

        /* change the following line by your code
        binFreeDataBlock(bn);*/

	SOSuperBlock* superBockPointer = soGetSuperBlockPointer();

	if (superBockPointer->tail_cache.idx==TAIL_CACHE_SIZE) {
		soDepleteTailCache();
	}

	superBockPointer -> tail_cache.ref[superBockPointer->tail_cache.idx] = bn;
	superBockPointer -> tail_cache.idx++;
	superBockPointer -> dz_free++;

	soSaveSuperBlock();
    }
};

