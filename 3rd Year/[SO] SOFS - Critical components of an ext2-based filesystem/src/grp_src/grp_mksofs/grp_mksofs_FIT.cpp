#include "grp_mksofs.h"

#include "rawdisk.h"
#include "core.h"
#include "bin_mksofs.h"

#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sys/stat.h>
#include <inttypes.h>

#include <inode.h>

namespace sofs19 {

    SOInode grpInitInode(SOInode inode, uint16_t mode, uint16_t lnkcnt, uint32_t owner, uint32_t group, uint32_t size, uint32_t blkcnt,
                         bool set_date, uint32_t next) {

        inode.mode = mode;
        inode.lnkcnt = lnkcnt;
        inode.owner = owner;
        inode.group = group;
        inode.size = size;
        inode.blkcnt = blkcnt;
        if (set_date) {
            inode.atime = (uint32_t) time(NULL);
            inode.ctime = (uint32_t) time(NULL);
            inode.mtime = (uint32_t) time(NULL);
        } else {
            inode.next = next;
            inode.ctime = 0;
            inode.mtime = 0;
        }
        return inode;
    }

    void grpFillInodeTable(uint32_t itotal, bool set_date) {
        soProbe(604, "%s(%u)\n", __FUNCTION__, itotal);

        /* change the following line by your code */
        SOInode inodes[itotal / IPB][IPB];

        for (unsigned long i = 0; i < (itotal / IPB); i++) {
            for (unsigned long k = 0; k < IPB; k++) {
                SOInode inode;

                for (int j = 0; j < N_DIRECT; j++) {
                    inode.d[j] = NullReference;
                }

                for (int j = 0; j < N_INDIRECT; j++) {
                    inode.i1[j] = NullReference;
                }

                for (int j = 0; j < N_DOUBLE_INDIRECT; j++) {
                    inode.i2[j] = NullReference;
                }

                if (i == 0 && k == 0) {
                    inodes[0][0] = grpInitInode(inode, S_IFDIR | 0775, 2, getuid(), getgid(), BlockSize, 1, set_date, 1);
                    inodes[0][0].d[0] = 0;
                } else {
                    inodes[i][k] = grpInitInode(inode, INODE_FREE, 0, 0, 0, 0, 0, false, (i * IPB) + k + 1);
                }
            }
            soWriteRawBlock(i + 1, inodes[i]);
        }
    }
};

