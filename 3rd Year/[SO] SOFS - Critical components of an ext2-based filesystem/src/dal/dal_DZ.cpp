#include "dal.h"
#include "bin_dal.h"

#include "rawdisk.h"
#include "core.h"

#include <inttypes.h>

namespace sofs19
{

    void soReadDataBlock(uint32_t bn, void *buf)
    {
        binReadDataBlock(bn, buf);
    }

    /* ***************************************** */

    void soWriteDataBlock(uint32_t bn, void *buf)
    {
        binWriteDataBlock(bn, buf);
    }

    /* ***************************************** */
};
