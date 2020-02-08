#include "grp_mksofs.h"

#include "rawdisk.h"
#include "core.h"
#include "bin_mksofs.h"

#include <string.h>
#include <inttypes.h>

namespace sofs19 {
    void grpResetFreeDataBlocks(uint32_t ntotal, uint32_t itotal, uint32_t nbref) {
        soProbe(607, "%s(%u, %u, %u)\n", __FUNCTION__, ntotal, itotal, nbref);

        //binResetFreeDataBlocks(ntotal, itotal, nbref);
        int start = itotal/IPB+2+nbref;
        int end = ntotal-1;
        int buffer[RPB] = {0};
        int i;
        for (i = start; i <= end; i++) {
            soWriteRawBlock(i,buffer);
        }
    }
};