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
    void grpAddDirEntry(int pih, const char *name, uint32_t cin)
    {
        soProbe(202, "%s(%d, %s, %u)\n", __FUNCTION__, pih, name, cin);

        SOInode* pin = soGetInodePointer(pih);
        unsigned free_block_fbn = NullReference;
        unsigned free_ref_index = NullReference;

        for (unsigned i=0; i < pin->size/BlockSize; i++) {
            SODirEntry entries[DPB];
            soReadFileBlock(pih,i,entries);
            for (unsigned j=0; j < DPB; j++) {
                if (strcmp(name, entries[j].name) == 0) {
                    throw SOException(EEXIST, __FUNCTION__);
                }
                if (free_block_fbn == NullReference && entries[j].name[0] == '\0') {
                    free_block_fbn = i;
                    free_ref_index = j;
                }
            }
        }

        SODirEntry entries[DPB];

        if (free_block_fbn == NullReference) {
            free_block_fbn = pin->size/BlockSize;
            free_ref_index = 0;
            soAllocFileBlock(pih, free_block_fbn);
            pin->size += BlockSize;

            for (unsigned long i = 0; i < DPB; i++) {
                entries[i].in = NullReference;
                strcpy(entries[i].name, "");
            }
        }
        else {
            soReadFileBlock(pih, free_block_fbn,entries);
        }

        entries[free_ref_index].in = cin;
        strcpy(entries[free_ref_index].name, name);

        soWriteFileBlock(pih, free_block_fbn, entries);
    }
};

