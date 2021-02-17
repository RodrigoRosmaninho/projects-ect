/**
 * \file
 * \brief Main functions of the disk abstraction (\c dal) layer module
 */

#ifndef __SOFS19_DAL__
#define __SOFS19_DAL__

#include <inttypes.h>

#include "superblock.h"
#include "inode.h"

namespace sofs19
{

    /**
     * \defgroup dal dal
     * \brief Disk abstraction layer 
     * \details This layer is used to prevent higher level functions
     *      from access disk blocks at raw level.
     * @{ 
     */

    /* ***************************************** */

    /**
     * \brief Open disk at sofs19 abstraction level
     *
     * Open disk at raw level and then open superblok (SB)
     * and inode table (IT) abstraction modules.
     * The other sofs19 abstraction modules do not need to be initialized.
     * They are: free inode list table (FILT) module,
     * free block list table (FBLT) module,
     * and data zone (DZ) module.
     */
    void soOpenDisk(const char *devname);

    /* ***************************************** */

    /**
     * \brief Close disk at sofs19 abstraction level
     *
     * First close sofs19 abstraction modules and then
     * close disk at raw level.
     */
    void soCloseDisk();

    /* ***************************************** */
    /* ***************************************** */

    /**
     * \brief Open the superblock dealer
     *
     * Prepare the internal data structure of the superblock dealer
     */
    void soOpenSuperBlock();

    /* ***************************************** */

    /**
     * \brief Close the superblock dealer
     *
     * Save superblock to disk and close dealer
     * Do nothing if not loaded
     */
    void soCloseSuperBlock();

    /* ***************************************** */

    /**
     * \brief Save superblock to disk
     *
     * Do nothing if not loaded
     */
    void soSaveSuperBlock();

    /* ***************************************** */

    /**
     * \brief Get a pointer to the superblock
     *
     * Load the superblock, if not done yet
     *
     * \return Pointer to the superblock
     */
    SOSuperBlock *soGetSuperBlockPointer();

    /* ***************************************** */
    /* ***************************************** */

    /**
     * \brief Open inode table dealer
     *
     * Prepare the internal data structure for the inode table dealer
     */
    void soOpenInodeTable();

    /* ***************************************** */

    /**
     * \brief Close the inode table dealer
     *
     * Save to disk all openning inodes and close dealer
     */
    void soCloseInodeTable();

    /* ***************************************** */

    /**
     * \brief open inode
     *
     * If inode is already open, just increment usecount;
     * otherwise, transfer the inode from disk and 
     * put usecount at 1.
     *
     * \param in the number of the inode to open
     * \return inode handler
     */
    int soOpenInode(uint32_t in);

    /* ***************************************** */

    /**
     * \brief Check given handler, throwing an exception in case of error
     * \param ih the handler to be checked
     * \param funcname name of the function making the ckeck
     */
    void soCheckInodeHandler(int ih, const char *funcname = __FUNCTION__);

    /* ***************************************** */

    /**
     * \brief get pointer to an open inode
     *
     * A pointer to the SOInode structured where the inode
     * is loaded is returned.
     *
     * \param ih inode handler
     * \return pointer to the inode
     */
    SOInode *soGetInodePointer(int ih);

    /* ***************************************** */

    /**
     * \brief Save an open inode to disk
     *
     * The inode is not closed.
     *
     * \param ih inode handler
     */
    void soSaveInode(int ih);

    /* ***************************************** */

    /**
     * \brief Close an open inode
     *
     * Decrement usecount of given inode,
     * releasing slot if 0 is reached.
     *
     * \param ih inode handler
     */
    void soCloseInode(int ih);

    /* ***************************************** */

    /**
     * \brief Return the number of the inode associated to the given handler
     * \param ih inode handler
     * \return inode number
     */
    uint32_t soGetInodeNumber(int ih);

    /* ***************************************** */
    /* ***************************************** */

    /**
     * \brief check an open inode against a requested access
     * \details access is a bitwise OR of one or more of R_OK, W_OK, and X_OK
     * \sa man 2 access
     * \param ih inode handler
     * \param access requested access
     * \return true, for access granted; false for access denied
     */
    bool soCheckInodeAccess(int ih, int access);

    /* ***************************************** */
    /* ***************************************** */

    /**
     * \brief Read a block of the data zone
     *
     * \param[in] bn number of block to be read
     * \param[in] buf pointer to the buffer where the data must be read into
     */
    void soReadDataBlock(uint32_t bn, void *buf);

    /* ***************************************** */

    /**
     * \brief Write a block of the data zone
     *
     * \param[in] bn number of block to be read
     * \param[in] buf pointer to the buffer where the data must be written from
     */
    void soWriteDataBlock(uint32_t bn, void *buf);

    /* ***************************************** */

    /** @} close group dal */
    /* ***************************************** */

};


#endif /* __SOFS19_DAL__ */
