/**
 * \file
 * \brief Binary version of functions to manage the list of free inodes 
 *      and the list of free blocks
 * 
 *  \author Artur Pereira 2008-2009, 2016-2019
 *  \author Miguel Oliveira e Silva 2009, 2017
 *  \author António Rui Borges - 2010-2015
 *
 *  \remarks Refer to the main \c freelists header file for documentation
 *
 */

#ifndef __SOFS19_FREELISTS_GROUP__
#define __SOFS19_FREELISTS_GROUP__

#include <inttypes.h>

namespace sofs19
{
    uint32_t grpAllocInode(uint32_t type, uint32_t perm);

    void grpFreeInode(uint32_t in);

    uint32_t grpAllocDataBlock();

    void grpReplenishHeadCache();

    void grpFreeDataBlock(uint32_t cn);

    void grpDepleteTailCache();
};

#endif /* __SOFS19_FREELISTS_GROUP__ */
