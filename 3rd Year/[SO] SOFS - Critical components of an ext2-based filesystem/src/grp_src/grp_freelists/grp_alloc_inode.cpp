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
#include <sys/stat.h>
#include <string.h>

#include <iostream>

#include "core.h"
#include "dal.h"
#include "freelists.h"
#include "bin_freelists.h"

namespace sofs19
{
    uint32_t grpAllocInode(uint32_t type, uint32_t perm)
    {
        soProbe(401, "%s(0x%x, 0%03o)\n", __FUNCTION__, type, perm);

        if(!(type == S_IFREG || type == S_IFDIR || type == S_IFLNK)){
            throw SOException(EINVAL, __FUNCTION__);
        }

        if(perm < 0000 || perm > 0777){
            throw SOException(EINVAL, __FUNCTION__);
        }

        SOSuperBlock* psb = soGetSuperBlockPointer();

        if(psb->ifree == 0){
            throw SOException(ENOSPC, __FUNCTION__);
        }

        uint32_t inode_id = psb->ihead;

        int inode_handler = soOpenInode(inode_id);
        SOInode* pinode = soGetInodePointer(inode_handler);

        uint32_t next = pinode->next;

        pinode->mode = type | perm;
        pinode->atime = time(NULL);
        pinode->ctime = time(NULL);
        pinode->mtime = time(NULL);

        pinode->owner = getuid();
        pinode->group = getgid();

        psb->ifree = psb->ifree - 1;
        psb->ihead = next;

        if(psb->ifree == 0){
            psb->itail = NullReference;
        }

        soSaveInode(inode_handler);
        soSaveSuperBlock();

        return inode_id;
    }
};

