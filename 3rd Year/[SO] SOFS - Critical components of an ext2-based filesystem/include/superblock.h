/**
 *  \file 
 *  \brief Definition of the superblock data type.
 *
 *  \author Artur Pereira - 2008-2009, 2016-2019
 *  \author Miguel Oliveira e Silva - 2009, 2017
 *  \author António Rui Borges - 2010-2015
 */

#ifndef __SOFS19_SUPERBLOCK__
#define __SOFS19_SUPERBLOCK__

#include <inttypes.h>

namespace sofs19
{

    /** \defgroup superblock superblock
     * \brief The \c SOSuperBlock data type
     * \ingroup core
     */

    /** \brief sofs19 magic number 
     * \ingroup superblock
     */
#define MAGIC_NUMBER 0x50F5

    /** \brief sofs19 version number 
     * \ingroup superblock
     */
#define VERSION_NUMBER 0x2019

    /** \brief maximum length of volume name 
     * \ingroup superblock
     */
#define PARTITION_NAME_SIZE 21

    /** \brief size of caches in superblock for inode references
     * \ingroup superblock
     */
#define HEAD_CACHE_SIZE 64

    /** \brief size of caches in superblock for block references
     * \ingroup superblock
     */
#define TAIL_CACHE_SIZE 170

    /** \addtogroup superblock 
     * @{ 
     */

    /**
     *  \brief Definition of the superblock data type.
     */
    struct SOSuperBlock
    {

        /** \brief magic number - file system identification number */
        uint16_t magic;

        /** \brief version number */
        uint16_t version;

        /** \brief volume name */
        char name[PARTITION_NAME_SIZE + 1];

        /** \brief mount status (1: properly unmounted; 0: otherwise) */
        uint8_t mntstat;

        /** \brief number of mounts since last file system check */
        uint8_t mntcnt;

        /** \brief total number of blocks in the device */
        uint32_t ntotal;


        /* Inode meta data */

        /** \brief number of blocks that the inode table comprises */
        uint32_t it_size;

        /** \brief total number of inodes */
        uint32_t itotal;

        /** \brief number of free inodes */
        uint32_t ifree;

        /** \brief number of fist free inode */
        uint32_t ihead;

        /** \brief number of last free inode */
        uint32_t itail;


        /* Data blocks' metadata */

        /** \brief physical number of the block where the data zone starts */
        uint32_t dz_start;

        /** \brief total number of data blocks */
        uint32_t dz_total;

        /** \brief number of free blocks in data zone */
        uint32_t dz_free;

        /** \brief number of head reference data block */
        uint32_t head_blk;

        /** \brief first occupied position in head reference data block */
        uint32_t head_idx;

        /** \brief number of tail reference data block */
        uint32_t tail_blk;

        /** \brief first empty position in tail reference data block */
        uint32_t tail_idx;

        /** \brief head cache of references to free data blocks */
        struct HeadCache
        {
            uint32_t idx;
            uint32_t ref[HEAD_CACHE_SIZE];
        } head_cache;

        /** \brief tail cache of references to free data blocks */
        struct TailCache
        {
            uint32_t idx;
            uint32_t ref[TAIL_CACHE_SIZE];
        } tail_cache;

    };

    /** @} */

};

#endif /*__SOFS19_SUPERBLOCK__ */
