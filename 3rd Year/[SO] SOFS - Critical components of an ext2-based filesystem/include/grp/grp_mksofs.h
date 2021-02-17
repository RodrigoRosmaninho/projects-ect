/**
 *  \file
 *  \brief Student version of the \b sofs19 formatting functions.
 *
 *  \author Artur Pereira - 2019
 *
 *  \remarks See the main \c mksofs header file for documentation
 */

#ifndef __SOFS19_MKSOFS_GROUP__
#define __SOFS19_MKSOFS_GROUP__

#include <inttypes.h>

namespace sofs19
{
    void grpComputeStructure(uint32_t ntotal, uint32_t & itotal, uint32_t & nbref);

    void grpFillSuperBlock(const char *name, uint32_t ntotal, uint32_t itotal, uint32_t nbref);

    void grpFillInodeTable(uint32_t itotal, bool set_date = true);

    void grpFillRootDir(uint32_t itotal);

    void grpFillReferenceDataBlocks(uint32_t ntotal, uint32_t itotal, uint32_t nbref);

    void grpResetFreeDataBlocks(uint32_t ntotal, uint32_t itotal, uint32_t nbref);
};

#endif /* __SOFS19_MKSOFS_GROUP__ */
