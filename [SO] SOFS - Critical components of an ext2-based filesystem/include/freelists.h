/**
 * \file
 * \brief Functions to manage the list of free inodes and the list of free data blocks
 * 
 *  \author Artur Pereira 2008-2009, 2016-2019
 *  \author Miguel Oliveira e Silva 2009, 2017
 *  \author António Rui Borges - 2010-2015
 *
 */

#ifndef __SOFS19_FREELISTS__
#define __SOFS19_FREELISTS__

#include <inttypes.h>

namespace sofs19
{

    /**
     * \defgroup ilayers ilayers
     * \brief Intermediate functions
     */

    /**
     * \defgroup freelists freelists
     * \ingroup ilayers
     * \brief Functions to manage the list of free inodes and the list of free blocks.
     * \remarks In case an error occurs, every function throws an \c SOException.
     * @{ 
     */

    /* *************************************************** */

    /**
     *  \brief Allocate a free inode.
     *
     *  An inode is retrieved from the list of free inodes 
     *      and is properly initialized.
     *
     *  \param [in] type the inode type 
     *  \param [in] perm permissions of the newly allocated inode
     *
     *  \remarks
     *
     *  \li \c type must represent either a file (\c S_IFREG), 
     *          a directory (\c S_IFDIR), or a symbolic link (\c S_IFLNK);
     *          if not, error \c EINVAL is thrown;
     *  \li \b perm must represent a valid permission pattern (a octal value in the
     *          range 0000 to 0777);
     *          if not, error \c EINVAL is thrown;
     *  \li if there are no free inodes, error \c ENOSPC is thrown;
     *  \li when calling a function of any layer, the version with prefix \c so is used.
     *
     *  \return the reference (number) of the inode allocated
     */
    uint32_t soAllocInode(uint32_t type, uint32_t perm);

    /* *************************************************** */

    /**
     *  \brief Free the referenced inode.
     *
     * \details
     *  The inode is cleaned, marked as free, and inserted into the list of free inodes:
     *
     *  \param [in] in number (reference) of the inode to be freed
     *
     *  \remarks
     *  \li when calling a function of any layer, the version with prefix \c so is used.
     */
    void soFreeInode(uint32_t in);

    /* *************************************************** */

    /**
     *  \brief Allocate a free data block.
     *
     *  \details 
     *  A data block reference is retrieved from the head cache: 
     *
     *  \remarks
     *
     *  \li if there are no free data blocks, error \c ENOSPC is thrown;
     *  \li if the head cache is empty, it is replenished before the retrieval takes place;
     *  \li when calling a function of any layer, the version with prefix \c so is used.
     *
     *  \return the number (reference) of the data block allocated
     */
    uint32_t soAllocDataBlock();

    /* *************************************************** */

    /**
     *  \brief Free the referenced data block.
     *
     * \details
     *  The data block reference is inserted into the tail cache:
     *
     *  \param bn the number (reference) of the data block to be freed
     *
     *  \remarks
     *  \li if the cache is full, it is depleted before the insertion takes place;
     *  \li when calling a function of any layer, the version with prefix \c so is used.
     *
     */
    void soFreeDataBlock(uint32_t bn);

    /* *************************************************** */

    /**
     * \brief Replenish the head cache
     * \details References to free data blocks should be transferred from the 
     *      head reference data block or from the tail cache, if no reference data blocks exist,
     *      to the head cache:
     *
     *  \remarks
     *
     *  \li nothing is if the cache is not empty;
     *  \li the tail cache is only used if there are no reference data blocks;
     *  \li only a single block is processed, 
     *          even if it is not enough to fulfill the head cache;
     *  \li the block processed is the one pointed to by the \c head_blk field 
     *      of the superblock;
     *  \li after transferring a reference from A to B, the value in A becomes NullReference;
     *  \li if after the replenish the head reference data block gets empty, 
     *          the head passes to the next, if one exists, and the previous is freed;
     *  \li in the previous situation, all entries of the freed data block sre set to NullReference;
     *  \li when calling a function of any layer, the version with prefix \c so is used.
     */
    void soReplenishHeadCache();

    /* *************************************************** */

    /**
     * \brief Deplete the tail cache
     * \details References to free data blocks should be transferred from the tail cache
     *      to the tail reference data block.
     *
     *  \remarks
     *
     *  \li nothing is done if the cache is not full;
     *  \li only a single block is processed, 
     *          even if it has no room to empty the tail cache;
     *  \li the block processed is the one pointed to by the \c tail_blk field 
     *      of the superblock;
     *  \li if the previous block is full, a new reference data block is
     *      allocated, which becomes the new tail reference data block;
     *  \li if no reference data blocks exist, a new reference data block is
     *      allocated, which becomes the new head and tail reference data block;
     *  \li when calling a function of any layer, the version with prefix \c so is used.
     */
    void soDepleteTailCache();

    /* *************************************************** */

    /** @} close group freelists */
    /* *************************************************** */

};

#endif /* __SOFS19_FREELISTS__ */
