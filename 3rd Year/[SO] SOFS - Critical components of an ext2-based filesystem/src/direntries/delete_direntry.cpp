#include "direntries.h"
#include "bin_direntries.h"
#include "grp_direntries.h"

#include "core.h"

#include <errno.h>
#include <string.h>
#include <sys/stat.h>

namespace sofs19
{

    uint32_t soDeleteDirEntry(int pih, const char *name)
    {
        if (soBinSelected(203))
            return binDeleteDirEntry(pih, name);
        else
            return grpDeleteDirEntry(pih, name);
    }

};
