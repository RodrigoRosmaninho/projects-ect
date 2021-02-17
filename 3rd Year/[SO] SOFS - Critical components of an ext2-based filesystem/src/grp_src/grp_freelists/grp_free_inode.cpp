/*
 *  \author António Rui Borges - 2012-2015
 *  \authur Artur Pereira - 2016-2019
 */

#include "grp_freelists.h"

#include <stdio.h>
#include <errno.h>
#include <inttypes.h>
#include <time.h>
#include <unistd.h>
#include <sys/types.h>

#include "core.h"
#include "dal.h"
#include "freelists.h"
#include "bin_freelists.h"

namespace sofs19
{
    void grpFreeInode(uint32_t in)
    {
        soProbe(402, "%s(%u)\n", __FUNCTION__, in);

        SOSuperBlock* psb = soGetSuperBlockPointer();
        int inode_handler = soOpenInode(in);
        SOInode* pinode = soGetInodePointer(inode_handler);

        pinode->mode = INODE_FREE;
        pinode->lnkcnt = 0;
        pinode->owner = 0;
        pinode->group = 0;
        pinode->size = 0;
        pinode->blkcnt = 0;
        pinode->next = NullReference;
        pinode->ctime = 0;
        pinode->mtime = 0;

        for (int j = 0; j < N_DIRECT; j++) {
            pinode->d[j] = NullReference;
        }

        for (int j = 0; j < N_INDIRECT; j++) {
            pinode->i1[j] = NullReference;
        }

        for (int j = 0; j < N_DOUBLE_INDIRECT; j++) {
            pinode->i2[j] = NullReference;
        }

        if(psb->ifree != 0){
            int prev_tail = soOpenInode(psb->itail);
            SOInode* pprev = soGetInodePointer(prev_tail);
            pprev->next = in;
            soSaveInode(prev_tail);
        }
        else {
            psb->ihead = in;
        }

        psb->itail = in;
        psb->ifree = psb->ifree + 1;

        soSaveInode(inode_handler);
        soSaveSuperBlock();
    }
};

