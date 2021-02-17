#include "grp_mksofs.h"

#include "core.h"
#include "bin_mksofs.h"

#include <inttypes.h>
#include <iostream>

namespace sofs19 {
    void grpComputeStructure(uint32_t ntotal, uint32_t & itotal, uint32_t & nbref) {
        soProbe(601, "%s(%u, %u, ...)\n", __FUNCTION__, ntotal, itotal);

        //binComputeStructure(ntotal, itotal, nbref);

        if (itotal>ntotal/IPB || itotal<IPB)
            itotal=ntotal/16;

        if (itotal%IPB!=0) 
            itotal=(itotal/IPB+1)*IPB;
            
        uint32_t iBlocks=itotal/IPB;
        
        if (1+iBlocks+1+HEAD_CACHE_SIZE>=ntotal) 
            nbref=0;
        else {
            uint32_t dBlocks=ntotal-1-iBlocks-1-HEAD_CACHE_SIZE; // data blocks=ntotal - inode blocks - super block - root directory - HEAD_CACHE_SIZE
            uint32_t rem=dBlocks%RPB;
            if (rem==1){
                itotal += 8;
                nbref=(dBlocks-1)/RPB;
            } 
            else nbref=dBlocks/RPB+1;
        }
    }
};

