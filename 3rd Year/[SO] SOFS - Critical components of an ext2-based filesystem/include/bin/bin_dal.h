/**
 * \file
 * \brief Binary version of the disk abstraction layer module
 */

#ifndef __SOFS19_BIN_DAL__
#define __SOFS19_BIN_DAL__

#include <inttypes.h>

#include "superblock.h"
#include "inode.h"

namespace sofs19
{
    void binOpenSuperBlock();

    void binCloseSuperBlock();

    void binSaveSuperBlock();

    SOSuperBlock *binGetSuperBlockPointer();

    /* ***************************************** */

    void binOpenInodeTable();

    void binCloseInodeTable();

    int binOpenInode(uint32_t in);

    SOInode *binGetInodePointer(int ih);

    void binSaveInode(int ih);

    void binCloseInode(int ih);

    uint32_t binGetInodeNumber(int ih);

    /* ***************************************** */

    bool binCheckInodeAccess(int ih, int access);

    /* ***************************************** */

    void binReadDataBlock(uint32_t bn, void *buf);

    void binWriteDataBlock(uint32_t bn, void *buf);
};


#endif /* __SOFS19_BIN_DAL__ */
