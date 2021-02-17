/*
 *  \author António Rui Borges - 2012-2015
 *  \authur Artur Pereira - 2016-2019
 */

#include "grp_freelists.h"

#include "core.h"
#include "dal.h"
#include "freelists.h"
#include "bin_freelists.h"

#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <iostream>
using namespace std;

namespace sofs19
{
    /* only fill the current block to its end */
    void grpDepleteTailCache(void)
    {
        soProbe(444, "%s()\n", __FUNCTION__);

        /* change the following line by your code */
        //binDepleteTailCache();

        SOSuperBlock* psb=soGetSuperBlockPointer();

        if (psb->tail_cache.idx<TAIL_CACHE_SIZE) {
            return; // tail cache is not full
        }
        
        int firstFree=0; // first free position in RDB
        uint32_t buffer[RPB];
        uint32_t block=0; // which block to write to
        
        if (psb->head_blk==NullReference // no RDBs exist, allocate new (which is new head and tail)
            || psb->tail_idx==RPB || psb->tail_idx==NullReference) { // tail RDB is full, allocate new data block

            buffer[0]=NullReference; // a new RDB becomes the tail
            
            block=grpAllocDataBlock(); // next free block
            firstFree=1; // first free position is the one after reference to next RDB (nil)

            uint32_t lastBlk=psb->tail_blk;
            psb->tail_blk=block; // new tail is the first free data block

            if (psb->head_blk==NullReference) {
                psb->head_blk=block; // set head RDB
                psb->head_idx=1; // set first occupied position in head RDB
            }
            else if (psb->tail_idx==RPB || psb->tail_idx==NullReference) {
                uint32_t lastTail[RPB];
                soReadDataBlock(lastBlk,&lastTail);
                lastTail[0]=psb->tail_blk; // update the previous tail RDB to point to the new one
                soWriteDataBlock(lastBlk,&lastTail);
            }

        }
        else { // RDBs exist and the tail is not full (no need to allocate new block, use current tail)
            block=psb->tail_blk; // write to the tail RDB
            firstFree=psb->tail_idx;

            soReadDataBlock(psb->tail_blk,&buffer);
        }

        unsigned int i=firstFree; // index in RDB
        unsigned int j=0; // index in cache
        for (;i<RPB && j<TAIL_CACHE_SIZE;i++,j=i-firstFree) {
            buffer[i]=psb->tail_cache.ref[j];
            psb->tail_cache.ref[j]=NullReference;
        }

        for (unsigned int nil=i;nil<RPB;nil++) buffer[nil]=NullReference; // fill remaining entries in RDB with nil

        unsigned int k=0;
        for (;j<TAIL_CACHE_SIZE;j++,k++) { // place remaining cache in beginning
            psb->tail_cache.ref[k]=psb->tail_cache.ref[j];
            psb->tail_cache.ref[j]=NullReference;
        }
        psb->tail_cache.idx=k;

        soWriteDataBlock(block,&buffer); // write to block
        
        psb->tail_idx=i; // set first empty position in tail RDB

        soSaveSuperBlock(); // write to SB
        
    }
};

