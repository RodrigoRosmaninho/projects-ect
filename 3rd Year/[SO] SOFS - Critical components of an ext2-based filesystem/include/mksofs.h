/**
 *  \file
 *  \brief The \b sofs19 formatting functions.
 *
 *  \author Artur Pereira - 2007-2009, 2016-2019
 *  \author Miguel Oliveira e Silva - 2009, 2017
 *  \author António Rui Borges - 2010-2015
 */

#ifndef __SOFS19_MKSOFS__
#define __SOFS19_MKSOFS__

#include <inttypes.h>

namespace sofs19
{

    /**
     * \defgroup mksofs mksofs
     * \brief Supporting formatting functions
     * @{ 
     * */

    /* ******************************************************************* */

    /**
     * \brief computes the structural division of the disk
     * \param [in] ntotal Total number of blocks of the disk
     * \param [in, out] itotal Total number of inodes
     * \param [out] nbref Number of reference data blocks in a newly-formatted disk
     * \remarks
     *     \li this function does not change any block of the disk;
     *     \li if it is zero initially, the value <code>ntotal/16</code>
     *          should be used as the start value for \c itotal,
     *          where / stands for the integer division;
     *     \li \c itotal is always lower than or equal to <code>ntotal/8</code>;
     *     \li \c itotal is always greater than or equal to \c IPC;
     *     \li \c itotal must be rounded up to be multiple of \c IPB;
     *     \li if, after splitting data blocks between reference data blocks and free
     *          data blocks, a single data block remains, it is assigned to the inode table;
     */
    void soComputeStructure(uint32_t ntotal, uint32_t & itotal, uint32_t & nbref);


    /**
     * \brief Fill in the fields of the superblock.
     * \param [in] name volume name
     * \param [in] ntotal the total number of blocks in the device
     * \param [in] itotal the total number of inodes
     * \param [in] nbref Number of reference data blocks in a newly-formatted disk
     * \remarks
     *      \li the magic number is put at \c 0xFFFF;
     *      \li The tail cache is left empty;
     *      \li the head cache is left filled (totally, if possible).      
     */
    void soFillSuperBlock(const char *name, uint32_t ntotal, uint32_t itotal, uint32_t nbref);


    /**
     * \brief Fill in the blocks of the inode table.
     * \param [in] itotal the total number of inodes
     * \param [in] set_date if \c true current date is set; otherwise date is put at zero
     * \remarks
     *      \li inode table starts on block number 1;
     *      \li all inodes are free, except inode number 0;
     *      \li inode 0 is filled assuming it is used by the root directory;
     *      \li the data of inode 0 is stored in data block number 0;
     *      \li the first free inode is inode number 1, the second inode number 2, and
     *                  do forth;
     *      \li the last free inode points to NullReference.
     */
    void soFillInodeTable(uint32_t itotal, bool set_date = true);


    /** 
     * \brief Fill in the root directory
     * \param [in] itotal the total number of inodes
     * \remarks
     *      \li in the newly-formatted disk the root directory occupies a single data block,
     *          the one immediately after the inode table;
     *      \li the whole data block is formatted as an array of \c DPB directory entries;
     *      \li the first two entries are filled in with
     *              \c "." and \c ".." directory entries;
     *      \li the other slots must be cleaned: 
     *              field \c name filled with zeros and field \c inode
     *              filled with \c NullReference.
     */
    void soFillRootDir(uint32_t itotal);


    /**
     * \brief Fill in the data blocks containing references to free data blocks in
     *      a newly-formatted disk.
     * \param [in] ntotal the total number of blocks in the device
     * \param [in] itotal the total number of inodes
     * \param [in] nbref Number of reference data blocks in a newly-formatted disk
     * \remarks
     *      \li the list of free data blocks is sorted in ascending order;
     *      \li the first references of the list are in the head cache;
     *      \li non-used cells must be filled with pattern NullReference;
     *      \li this function does nothing, in case all
     *              references to free data blocks fit in the head cache.
     */
    void soFillReferenceDataBlocks(uint32_t ntotal, uint32_t itotal, uint32_t nbref);


    /**
     * \brief Fill with zeros the free data blocks of a newly-formatted disk.
     * \param [in] ntotal the total number of blocks in the device
     * \param [in] itotal the total number of inodes
     * \param [in] nbref Number of reference data blocks in a newly-formatted disk
     */
    void soResetFreeDataBlocks(uint32_t ntotal, uint32_t itotal, uint32_t nbref);

    /* ***************************************** */

    /* ******************************************************************* */

    /** @} close group mksofs */
    /* ******************************************************************* */
};

#endif /* __SOFS19_MKSOFS__ */
