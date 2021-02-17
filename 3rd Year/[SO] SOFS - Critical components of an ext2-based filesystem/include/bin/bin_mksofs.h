/**
 *  \file
 *  \brief Binary version of the \b sofs19 formatting functions.
 *
 *  \author Artur Pereira - 2007-2009, 2016-2019
 *  \author Miguel Oliveira e Silva - 2009, 2017
 *  \author António Rui Borges - 2010-2015
 */

#ifndef __SOFS19_MKSOFS_BIN__
#define __SOFS19_MKSOFS_BIN__

#include <inttypes.h>

namespace sofs19
{
    void binComputeStructure(uint32_t ntotal, uint32_t & itotal, uint32_t & bref);

    void binFillSuperBlock(const char *name, uint32_t ntotal, uint32_t itotal, uint32_t bref);

    void binFillInodeTable(uint32_t itotal, bool set_date = true);

    void binFillRootDir(uint32_t itotal);

    void binFillReferenceDataBlocks(uint32_t ntotal, uint32_t itotal, uint32_t bref);

    void binResetFreeDataBlocks(uint32_t ntotal, uint32_t itotal, uint32_t bref);
};

#endif /* __SOFS19_MKSOFS_BIN__ */
