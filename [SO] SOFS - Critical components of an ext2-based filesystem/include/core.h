/**
 *  \file
 *  \brief Some global constants and aggregation of core header files
 *
 *  \author Artur Pereira - 2016-2019
 */

#ifndef __SOFS19_CORE__
#define __SOFS19_CORE__

#include "exception.h"
#include "probing.h"
#include "binselection.h"
#include "superblock.h"
#include "inode.h"
#include "direntry.h"
#include "blockviews.h"

#include <inttypes.h>

/** \defgroup core core
 *  \brief Core functions and constants
 */

/** \defgroup constants constants 
 * \brief Core constants
 */

/** @{ */

/** \brief block size (in bytes) */
#define BlockSize 1024U

/** \brief number of inodes per block */
#define IPB (BlockSize / sizeof(SOInode))

/** \brief number of references per block */
#define RPB (BlockSize / sizeof (uint32_t))

/** \brief number of direntries per block */
#define DPB     (BlockSize / sizeof(SODirEntry))

/** \brief null reference to an inode or to a data block */
#define NullReference 0xFFFFFFFF

/** @} */

#endif /* __SOFS19_CORE__ */
