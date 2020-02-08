#include "fileblocks.h"
#include "bin_fileblocks.h"
#include "grp_fileblocks.h"

#include "core.h"

#include <errno.h>

namespace sofs19
{

    uint32_t soGetFileBlock(int ih, uint32_t fbn)
    {
        if (soBinSelected(301))
            return binGetFileBlock(ih, fbn);
        else
            return grpGetFileBlock(ih, fbn);
    }

};
