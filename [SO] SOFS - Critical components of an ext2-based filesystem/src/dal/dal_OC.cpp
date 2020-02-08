#include "dal.h"

#include "rawdisk.h"
#include "core.h"

#include <iostream>

namespace sofs19
{

    void soOpenDisk(const char *devname)
    {
        soProbe(SOPROBE_GREEN, 501, "%s(\"%s\")\n", __FUNCTION__, devname);

        soOpenRawDisk(devname);
        soOpenSuperBlock();
        soOpenInodeTable();
        SOSuperBlock* sbp = soGetSuperBlockPointer();
        sbp->mntstat = 0;
        if (sbp->mntcnt != 200)
            sbp->mntcnt += 1;
        soSaveSuperBlock();
    }

    void soCloseDisk()
    {
        soProbe(SOPROBE_GREEN, 502, "%s()\n", __FUNCTION__);

        SOSuperBlock* sbp = soGetSuperBlockPointer();
        sbp->mntstat = 1;
        soSaveSuperBlock();
        soCloseInodeTable();
        soCloseSuperBlock();
        soCloseRawDisk();
    }

};
