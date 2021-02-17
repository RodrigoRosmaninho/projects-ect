#include "direntries.h"
#include "bin_direntries.h"
#include "grp_direntries.h"

#include "core.h"

#include <string.h>
#include <errno.h>
#include <sys/stat.h>

namespace sofs19
{

    void soRenameDirEntry(int pih, const char *name, const char *newName)
    {
        if (soBinSelected(204))
            return binRenameDirEntry(pih, name, newName);
        else
            return grpRenameDirEntry(pih, name, newName);
    }

};
