#include "grp_mksofs.h"

#include "rawdisk.h"
#include "core.h"
#include "bin_mksofs.h"

#include <string.h>
#include <inttypes.h>

namespace sofs19
{
    /*
       filling in the contents of the root directory:
       the first 2 entries are filled in with "." and ".." references
       the other entries are empty.
       If rdsize is 2, a second block exists and should be filled as well.
       */
    void grpFillRootDir(uint32_t itotal)
    {
        soProbe(606, "%s(%u)\n", __FUNCTION__, itotal);

        /* change the following line by your code */
        SODirEntry dirEntry[DPB];

        dirEntry[0].in = 0;
        strcpy(dirEntry[0].name, ".");
        dirEntry[1].in = 0;
        strcpy(dirEntry[1].name, "..");

        for (unsigned long i = 2; i < DPB; i++) {
            dirEntry[i].in = NullReference;
            strcpy(dirEntry[i].name, "");
        }

        soWriteRawBlock(itotal/IPB + 1, dirEntry);
    }
};

