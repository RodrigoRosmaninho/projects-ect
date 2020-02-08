/*
 *  \author António Rui Borges - 2012-2015
 *  \authur Artur Pereira - 2016-2019
 */

#include "grp_freelists.h"

#include <string.h>
#include <errno.h>
#include <iostream>

#include "core.h"
#include "dal.h"
#include "freelists.h"
#include "bin_freelists.h"

namespace sofs19
{
    void grpReplenishHeadCache(void)
    {
        soProbe(443, "%s()\n", __FUNCTION__);

        /* change the following line by your code */
        //binReplenishHeadCache();

        // get super block pointer
        SOSuperBlock* psb = soGetSuperBlockPointer();

        // only process if
        if (psb->head_cache.idx == HEAD_CACHE_SIZE) {
            if (psb->head_blk == NullReference and psb->tail_blk == NullReference) {
                if (psb->tail_cache.idx == 0) {
                    // throw exception if there are no free block references anywhere
                    throw SOException(ENOSPC, __FUNCTION__);
                }
                else {
                    // get all available references up to 64 from tail cache
                    while (psb->tail_cache.idx > 0 and psb->head_cache.idx > 0) {
                        psb->head_cache.ref[--psb->head_cache.idx] = psb->tail_cache.ref[--psb->tail_cache.idx];
                        psb->tail_cache.ref[psb->tail_cache.idx] = NullReference;
                    }
                }
            }
            else {
                uint32_t rfdb[RPB];
                soReadDataBlock(psb->head_blk, &rfdb);

                // two cases: last RFDB (tail cache is the limit) or not (RPB is the limit)
                unsigned int end;
                if (psb->head_blk == psb->tail_blk) {
                    end = psb->tail_idx;
                }
                else {
                    end = RPB;
                }

                unsigned int ref_left = end-psb->head_idx;
                if (ref_left > HEAD_CACHE_SIZE) {
                    ref_left = HEAD_CACHE_SIZE;
                }
                psb->head_cache.idx = HEAD_CACHE_SIZE-ref_left;
                unsigned int tmp_hidx = psb->head_cache.idx;

                while (tmp_hidx < HEAD_CACHE_SIZE) {
                    psb->head_cache.ref[tmp_hidx++] = rfdb[psb->head_idx];
                    rfdb[psb->head_idx++] = NullReference;
                }

                // check if head block is empty
                if (psb->head_idx == end) {
                    //delete the reference block and make the next the head one, if it exists
                    uint32_t del_block = psb->head_blk;
                    psb->head_blk = rfdb[0];
                    psb->head_idx = 1;
                    soFreeDataBlock(del_block);
                    // there are no more RFDBs
                    if (psb->head_blk == NullReference) {
                        psb->head_idx = NullReference;
                        psb->tail_blk = NullReference;
                        psb->tail_idx = NullReference;
                    }
                }
                else {
                    // write the changed data block onto the disk
                    soWriteDataBlock(psb->head_blk, &rfdb);
                }
            }
            soSaveSuperBlock();
        }
    }
};

