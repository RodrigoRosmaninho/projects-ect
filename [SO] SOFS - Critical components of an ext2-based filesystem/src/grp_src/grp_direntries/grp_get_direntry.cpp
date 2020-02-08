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
    uint32_t grpGetDirEntry(int pih, const char *name)
    {
        soProbe(201, "%s(%d, %s)\n", __FUNCTION__, pih, name);

        /* change the following line by your code 
        return binGetDirEntry(pih, name);*/

		for (unsigned i=0;name[i]!='\0';i++) {
			if (name[i]=='/') throw SOException(EINVAL, __FUNCTION__);
		}

		SOInode* pin = soGetInodePointer(pih);
		
		for (unsigned i=0; i<pin->size/BlockSize;i++) {
			SODirEntry entries[DPB];
			soReadFileBlock(pih,i,entries);
			for (unsigned j=0;j<DPB;j++) {
				if (strcmp(entries[j].name,name) == 0) {
					return entries[j].in;
				}
			}
		}

        return NullReference;
    }
};

