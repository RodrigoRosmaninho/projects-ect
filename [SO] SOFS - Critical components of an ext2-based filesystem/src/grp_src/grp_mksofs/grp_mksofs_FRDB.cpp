#include "grp_mksofs.h"

#include "rawdisk.h"
#include "core.h"
#include "bin_mksofs.h"

#include <inttypes.h>
#include <string.h>

namespace sofs19
{
    void grpFillReferenceDataBlocks(uint32_t ntotal, uint32_t itotal, uint32_t nbref)
    {
        soProbe(605, "%s(%u, %u, %u)\n", __FUNCTION__, ntotal, itotal, nbref);

        /* change the following line by your code */
        //return binFillReferenceDataBlocks(ntotal, itotal, nbref);

        int iBlocks=itotal/IPB;

        uint32_t nextRDB=2;
        uint32_t freeBlock=HEAD_CACHE_SIZE+nbref+1;
        uint32_t lastBlock=ntotal-1-iBlocks-1;
        uint32_t buffer[RPB];

        while (nextRDB-2<nbref) {
            if (nextRDB-2==nbref-1) buffer[0]=NullReference;
            else buffer[0]=nextRDB;
            for (unsigned int i=1;i<RPB;i++) {
                if (freeBlock<=lastBlock) buffer[i]=freeBlock++;
                else buffer[i]=NullReference;
            }
            soWriteRawBlock(nextRDB+iBlocks,buffer);
            nextRDB++;
        }
    }
};

