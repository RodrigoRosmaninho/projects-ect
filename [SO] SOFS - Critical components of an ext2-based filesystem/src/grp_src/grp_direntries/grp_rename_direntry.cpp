#include "direntries.h"

#include "core.h"
#include "dal.h"
#include "fileblocks.h"
#include "bin_direntries.h"

#include <string.h>
#include <errno.h>
#include <sys/stat.h>

namespace sofs19
{
    void grpRenameDirEntry(int pih, const char *name, const char *newName)
    {
        soProbe(204, "%s(%d, %s, %s)\n", __FUNCTION__, pih, name, newName);

        // binRenameDirEntry(pih, name, newName);

        SOInode* pin=soGetInodePointer(pih);
        unsigned block_index=NullReference;
        unsigned entry_index=NullReference;

        for (unsigned i=0;i<pin->size/BlockSize;i++) { //iterate through all blocks to find entry
            SODirEntry entries[DPB];
            soReadFileBlock(pih,i,entries);
            for (unsigned j=0;j<DPB;j++) {
                if (strcmp(newName,entries[j].name)==0) {
                    throw SOException(EEXIST, __FUNCTION__);
                }
                if (strcmp(name,entries[j].name)==0) {
                    block_index=i;
                    entry_index=j;
                }
            }
        }

        SODirEntry entries[DPB];

        if (block_index==NullReference) {
            throw SOException(ENOENT,__FUNCTION__);
        }

        strcpy(entries[entry_index].name,newName);
        soWriteFileBlock(pih,block_index,entries);

    }
};

