/**
 *  \file 
 *  \brief Binary version of function to manage file blocks
 *
 *  \author Artur Pereira - 2008-2009, 2016-2019
 *  \author Miguel Oliveira e Silva - 2009, 2017
 *  \author António Rui Borges - 2010-2015
 *
 */

#ifndef __SOFS19_FILEBLOCKS_BIN__
#define __SOFS19_FILEBLOCKS_BIN__

#include <inttypes.h>

namespace sofs19
{
    uint32_t binGetFileBlock(int ih, uint32_t fbn);

    uint32_t binAllocFileBlock(int ih, uint32_t fbn);

    void binFreeFileBlocks(int ih, uint32_t ffbn);

    void binReadFileBlock(int ih, uint32_t fbn, void *buf);

    void binWriteFileBlock(int ih, uint32_t fbn, void *buf);
};

#endif /* __SOFS19_FILEBLOCKS_BIN__ */
