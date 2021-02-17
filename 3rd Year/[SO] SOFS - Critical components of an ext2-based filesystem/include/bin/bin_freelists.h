/**
 * \file
 * \brief Binary version of functions to manage the list of free inodes 
 *      and the list of free blocks
 * 
 *  \author Artur Pereira 2008-2009, 2016-2019
 *  \author Miguel Oliveira e Silva 2009, 2017
 *  \author António Rui Borges - 2010-2015
 *
 */

/*
 * \defgroup freelists freelists
 *
 * @{
 *
 *  \remarks In case an error occurs, every function throws an SOException
 */

#ifndef __SOFS19_FREELISTS_BIN__
#define __SOFS19_FREELISTS_BIN__

#include <inttypes.h>

namespace sofs19
{
    uint32_t binAllocInode(uint32_t type, uint32_t perm);

    void binFreeInode(uint32_t in);

    uint32_t binAllocDataBlock();

    void binReplenishHeadCache();

    void binFreeDataBlock(uint32_t bn);

    void binDepleteTailCache();
};

#endif /* __SOFS19_FREELISTS_BIN__ */
