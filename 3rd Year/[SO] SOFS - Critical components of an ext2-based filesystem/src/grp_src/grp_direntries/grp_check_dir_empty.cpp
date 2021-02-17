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
    bool grpCheckDirEmpty(int ih)
    {
        soProbe(205, "%s(%d)\n", __FUNCTION__, ih);

        /* change the following line by your code
        return binCheckDirEmpty(ih); */
	SOInode* pin = soGetInodePointer(ih);
	
	for (unsigned i=0; i<pin->size/BlockSize;i++) {
		SODirEntry entries[DPB];
		soReadFileBlock(ih,i,entries);
		for (unsigned j=2;j<DPB;j++) {
			if (strcmp(entries[j].name,"\0") != 0) {
				return false;
			}
		}
	}

	return true;
    }
};

