#include "direntries.h"
#include "bin_direntries.h"
#include "grp_direntries.h"

#include "core.h"

#include <errno.h>
#include <string.h>
#include <sys/stat.h>

namespace sofs19
{

    void soAddDirEntry(int pih, const char *name, uint32_t cin)
    {
        if (soBinSelected(202))
            return binAddDirEntry(pih, name, cin);
        else
            return grpAddDirEntry(pih, name, cin);
    }

};
