#include "direntries.h"
#include "bin_direntries.h"
#include "grp_direntries.h"

#include "core.h"

#include <errno.h>
#include <string.h>
#include <sys/stat.h>

namespace sofs19
{

    uint32_t soGetDirEntry(int pih, const char *name)
    {
        if (soBinSelected(201))
            return binGetDirEntry(pih, name);
        else
            return grpGetDirEntry(pih, name);
    }

};
