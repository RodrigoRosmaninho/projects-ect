#include "direntries.h"

#include "core.h"
#include "dal.h"
#include "fileblocks.h"
#include "bin_direntries.h"

#include <errno.h>
#include <string.h>
#include <sys/stat.h>

namespace sofs19
{
    uint32_t grpDeleteDirEntry(int pih, const char *name)
    {
        soProbe(203, "%s(%d, %s)\n", __FUNCTION__, pih, name);

        /* change the following line by your code */
        //return binDeleteDirEntry(pih, name);

        SOInode* pin=soGetInodePointer(pih);

        for (unsigned i=0;i<pin->size/BlockSize;i++) { //iterate through all blocks to find entry
            SODirEntry entries[DPB];
            soReadFileBlock(pih,i,entries);
            for (unsigned j=0;j<DPB;j++) {
                if (strcmp(name,entries[j].name)==0) {
                    entries[j].name[27]=entries[j].name[0];
                    entries[j].name[0]='\0';
                    uint32_t in=entries[j].in;
                    entries[j].in=NullReference;
                    soWriteFileBlock(pih,i,entries);
                    return in;
                }
            }
        }
        throw SOException(ENOENT,__FUNCTION__);
    }
};

