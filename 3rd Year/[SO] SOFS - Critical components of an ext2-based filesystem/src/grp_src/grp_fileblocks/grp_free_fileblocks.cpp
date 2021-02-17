#include "grp_fileblocks.h"

#include "freelists.h"
#include "dal.h"
#include "core.h"
#include "bin_fileblocks.h"

#include <inttypes.h>
#include <errno.h>
#include <assert.h>

#include <iostream>

namespace sofs19
{
#if true
    /* free all blocks between positions ffbn and RPB - 1
     * existing in the block of references given by i1.
     * Return true if, after the operation, all references become NullReference.
     * It assumes i1 is valid.
     */
    static bool grpFreeIndirectFileBlocks(SOInode * ip, uint32_t i1, uint32_t ffbn);

    /* free all blocks between positions ffbn and RPB**2 - 1
     * existing in the block of indirect references given by i2.
     * Return true if, after the operation, all references become NullReference.
     * It assumes i2 is valid.
     */
    static bool grpFreeDoubleIndirectFileBlocks(SOInode * ip, uint32_t i2, uint32_t ffbn);
#endif

    /* ********************************************************* */

    unsigned totalFreed=0;

    void grpFreeFileBlocks(int ih, uint32_t ffbn)
    {
        soProbe(303, "%s(%d, %u)\n", __FUNCTION__, ih, ffbn);

        /* change the following line by your code */
        //binFreeFileBlocks(ih, ffbn);

        if (ffbn>=N_DIRECT+N_INDIRECT*RPB+N_DOUBLE_INDIRECT*RPB*RPB) throw SOException(EINVAL, __FUNCTION__);

        SOInode* pin=soGetInodePointer(ih);

        int dInd=0;
        int i1Ind=-1;
        int i2Ind=-1;

        if (ffbn<N_DIRECT) dInd=ffbn; //starting point is in d[]
        else if (ffbn<N_DIRECT+N_INDIRECT*RPB) { //starting point is in i1[] (d[] is not altered)
            dInd=N_DIRECT;
            i1Ind=(ffbn-N_DIRECT)/RPB;
        }
        else { //starting point is in i2[] (d[] and i1[] are not altered)
            dInd=N_DIRECT;
            i1Ind=N_INDIRECT;
            i2Ind=(ffbn-N_DIRECT-N_INDIRECT*RPB)/(RPB*RPB);
        }

        //process d[]
        for (unsigned i=0;i<N_DIRECT;i++) {
            if ((int)i>=dInd && pin->d[i]!=NullReference) {
                soFreeDataBlock(pin->d[i]);
                totalFreed++;
                pin->d[i]=NullReference;
            }
        }
        //process i1[]
        for (unsigned i=0;i<N_INDIRECT;i++) {
            if (pin->i1[i]!=NullReference) {
                bool nil=false;
                if ((int)i==i1Ind) nil=grpFreeIndirectFileBlocks(pin,pin->i1[i],(ffbn-N_DIRECT)%RPB);
                else if ((int)i>i1Ind) nil=grpFreeIndirectFileBlocks(pin,pin->i1[i],0);

                if (nil) {
                    soFreeDataBlock(pin->i1[i]);
                    totalFreed++;
                    pin->i1[i]=NullReference;
                }
            }
        }
        //process i2[]
        for (unsigned i=0;i<N_DOUBLE_INDIRECT;i++) {
            if (pin->i2[i]!=NullReference) {
                bool nil=false;
                if ((int)i==i2Ind) nil=grpFreeDoubleIndirectFileBlocks(pin,pin->i2[i],(ffbn-N_DIRECT-N_INDIRECT*RPB)%(RPB*RPB));
                else if ((int)i>i2Ind) nil=grpFreeDoubleIndirectFileBlocks(pin,pin->i2[i],0);

                if (nil) {
                    soFreeDataBlock(pin->i2[i]);
                    totalFreed++;
                    pin->i2[i]=NullReference;
                }
            }
        }

        pin->blkcnt-=totalFreed;

        soSaveInode(ih);
    }

    /* ********************************************************* */

#if true
    static bool grpFreeIndirectFileBlocks(SOInode * ip, uint32_t i1, uint32_t ffbn)
    {
        soProbe(303, "%s(..., %u, %u)\n", __FUNCTION__, i1, ffbn);

        /* change the following line by your code */
        //throw SOException(ENOSYS, __FUNCTION__); 

        uint32_t buffer[RPB];
        soReadDataBlock(i1,buffer);

        bool allNil=true; //whether all references are nil
        for (unsigned i=0;i<RPB;i++) {
            if (i>=ffbn && buffer[i]!=NullReference) {
                soFreeDataBlock(buffer[i]);
                totalFreed++;
                buffer[i]=NullReference;
            }
            if (buffer[i]!=NullReference) allNil=false;
        }
        soWriteDataBlock(i1,buffer);

        return allNil;
    }
#endif

    /* ********************************************************* */

#if true
    static bool grpFreeDoubleIndirectFileBlocks(SOInode * ip, uint32_t i2, uint32_t ffbn)
    {
        soProbe(303, "%s(..., %u, %u)\n", __FUNCTION__, i2, ffbn);

        /* change the following line by your code */
        //throw SOException(ENOSYS, __FUNCTION__); 

        uint32_t buffer[RPB];
        soReadDataBlock(i2,buffer);

        bool allNil=true; //whether all references are nil
        for (unsigned i=0;i<RPB;i++) {
            if (buffer[i]!=NullReference) {
                bool nil=false;
                if (i==ffbn/RPB) nil=grpFreeIndirectFileBlocks(ip,buffer[i],ffbn%RPB);
                else if (i>ffbn/RPB) nil=grpFreeIndirectFileBlocks(ip,buffer[i],0);

                if (nil) {
                    soFreeDataBlock(buffer[i]);
                    totalFreed++;
                    buffer[i]=NullReference;
                }
                if (buffer[i]!=NullReference) allNil=false;
            }
        }
        soWriteDataBlock(i2,buffer);

        return allNil;
    }
#endif

    /* ********************************************************* */
};

