#include "grp_fileblocks.h"

#include "freelists.h"
#include "dal.h"
#include "core.h"
#include "bin_fileblocks.h"

#include <errno.h>

#include <iostream>

namespace sofs19 {


    static uint32_t grpAllocIndirectFileBlock(SOInode *ip, uint32_t afbn);

    static uint32_t grpAllocDoubleIndirectFileBlock(SOInode *ip, uint32_t afbn);

    uint32_t i1size = N_INDIRECT * RPB;
    uint32_t i2size = N_DOUBLE_INDIRECT * (RPB * RPB);

    /* ********************************************************* */

    uint32_t grpAllocFileBlock(int ih, uint32_t fbn) {
        soProbe(302, "%s(%d, %u)\n", __FUNCTION__, ih, fbn);

        if (fbn >= N_DIRECT + i1size + i2size) {
            throw SOException(EINVAL, __FUNCTION__);
        }

        SOInode *ip = soGetInodePointer(ih);
        uint32_t dataBlock_ref;

        if (fbn < N_DIRECT) {
            dataBlock_ref = soAllocDataBlock();
            ip->blkcnt += 1;
            ip->d[fbn] = dataBlock_ref;
        }
        else if (fbn < N_DIRECT + i1size) {
            dataBlock_ref = grpAllocIndirectFileBlock(ip, fbn);
        }
        else {
            dataBlock_ref = grpAllocDoubleIndirectFileBlock(ip, fbn);
        }

        soSaveInode(ih);
        return dataBlock_ref;
    }

    /* ********************************************************* */


    /*
    */
    static uint32_t grpAllocIndirectFileBlock(SOInode *ip, uint32_t afbn) {
        soProbe(302, "%s(%d, ...)\n", __FUNCTION__, afbn);

        uint32_t block_ref;
        uint32_t i1_index = (afbn - N_DIRECT) / RPB;
        uint32_t rdb_index = (afbn - N_DIRECT) - (RPB * i1_index);
        uint32_t dataBlock_ref;
        uint32_t rdb_refs[RPB];

        if (ip->i1[i1_index] == NullReference) {
            block_ref = soAllocDataBlock();
            ip->blkcnt += 1;
            ip->i1[i1_index] = block_ref;
            for (unsigned long i = 0; i < RPB; i++) {
                rdb_refs[i] = NullReference;
            }
        }
        else {
            block_ref = ip->i1[i1_index];
            soReadDataBlock(block_ref, rdb_refs);
        }

        dataBlock_ref = soAllocDataBlock();
        ip->blkcnt += 1;
        rdb_refs[rdb_index] = dataBlock_ref;
        soWriteDataBlock(block_ref, rdb_refs);
        return dataBlock_ref;
    }


    /* ********************************************************* */


    /*
    */
    static uint32_t grpAllocDoubleIndirectFileBlock(SOInode *ip, uint32_t afbn) {
        soProbe(302, "%s(%d, ...)\n", __FUNCTION__, afbn);

        uint32_t i2_block_ref, i1_block_ref;
        uint32_t i2_index = (afbn - N_DIRECT - i1size) / (RPB * RPB);
        uint32_t i1_index = ((afbn - N_DIRECT - i1size) - (RPB * RPB * i2_index)) / RPB;
        uint32_t rdb_index = ((afbn - N_DIRECT - i1size) - (RPB * RPB * i2_index)) - (RPB * i1_index);
        uint32_t dataBlock_ref;
        uint32_t i1_refs[RPB], rdb_refs[RPB];

        if (ip->i2[i2_index] == NullReference) {
            i2_block_ref = soAllocDataBlock();
            ip->blkcnt += 1;
            ip->i2[i2_index] = i2_block_ref;
            for (unsigned long i = 0; i < RPB; i++) {
                i1_refs[i] = NullReference;
            }
        }
        else {
            i2_block_ref = ip->i2[i2_index];
            soReadDataBlock(i2_block_ref, i1_refs);
        }

        if (i1_refs[i1_index] == NullReference) {
            i1_block_ref = soAllocDataBlock();
            ip->blkcnt += 1;
            i1_refs[i1_index] = i1_block_ref;
            for (unsigned long i = 0; i < RPB; i++) {
                rdb_refs[i] = NullReference;
            }
        }
        else {
            i1_block_ref = i1_refs[i1_index];
            soReadDataBlock(i1_block_ref, rdb_refs);
        }

        dataBlock_ref = soAllocDataBlock();
        ip->blkcnt += 1;
        rdb_refs[rdb_index] = dataBlock_ref;

        soWriteDataBlock(i1_block_ref, rdb_refs);
        soWriteDataBlock(i2_block_ref, i1_refs);
        return dataBlock_ref;
    }

};

