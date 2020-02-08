#include "grp_fileblocks.h"

#include "dal.h"
#include "core.h"
#include "bin_fileblocks.h"

#include <errno.h>

namespace sofs19
{
    static uint32_t grpGetIndirectFileBlock(SOInode * ip, uint32_t afbn);
    static uint32_t grpGetDoubleIndirectFileBlock(SOInode * ip, uint32_t afbn);

    /* ********************************************************* */

    uint32_t grpGetFileBlock(int ih, uint32_t fbn)
    {
        soProbe(301, "%s(%d, %u)\n", __FUNCTION__, ih, fbn);

        uint32_t i1size = N_INDIRECT*RPB;
        uint32_t i2size = N_DOUBLE_INDIRECT*RPB*RPB;

        if (fbn >= N_DIRECT+i1size+i2size) {
            throw SOException(EINVAL, __FUNCTION__);
        }

        SOInode* inode = soGetInodePointer(ih);
        uint32_t block_ref;

        if (fbn < N_DIRECT) {
            block_ref = inode->d[fbn];
        }
        else if (fbn < N_DIRECT+i1size) {
            block_ref = grpGetIndirectFileBlock(inode, fbn-N_DIRECT);
        }
        else {
            block_ref = grpGetDoubleIndirectFileBlock(inode, fbn-N_DIRECT-i1size);
        }
        return block_ref;
    }

    /* ********************************************************* */

    static uint32_t grpGetIndirectFileBlock(SOInode * ip, uint32_t afbn)
    {
        soProbe(301, "%s(%d, ...)\n", __FUNCTION__, afbn);

        uint32_t i1_idx = afbn / RPB;
        uint32_t ref_idx = afbn % RPB;

        if (ip->i1[i1_idx] == NullReference) {
            return NullReference;
        }

        uint32_t ref[RPB];
        soReadDataBlock(ip->i1[i1_idx], &ref);
        return ref[ref_idx];
    }

    static uint32_t grpGetDoubleIndirectFileBlock(SOInode * ip, uint32_t afbn)
    {
        soProbe(301, "%s(%d, ...)\n", __FUNCTION__, afbn);

        uint32_t sqr_rpb = RPB*RPB;
        uint32_t i2_idx = afbn / sqr_rpb;
        uint32_t i1fdb_idx = (afbn / RPB) % RPB;
        uint32_t rdb_index = afbn % RPB % RPB;

        if (ip->i2[i2_idx] == NullReference) {
            return NullReference;
        }

        uint32_t ref_i1[RPB];
        soReadDataBlock(ip->i2[i2_idx], &ref_i1);
        if (ref_i1[i1fdb_idx] == NullReference) {
            return NullReference;
        }

        uint32_t ref[RPB];
        soReadDataBlock(ref_i1[i1fdb_idx], &ref);
        return ref[rdb_index];
    }
};

