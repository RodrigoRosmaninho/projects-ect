#include "dal.h"
#include "bin_dal.h"

#include "core.h"

#include <inttypes.h>

namespace sofs19
{
    /* ************************************** */

    void soOpenInodeTable()
    {
        binOpenInodeTable();
    }

    /* ***************************************** */

    void soCloseInodeTable()
    {
        binCloseInodeTable();
    }

    /* ************************************** */

    int soOpenInode(uint32_t in)
    {
        return binOpenInode(in);
    }

    /* ************************************** */

    void soSaveInode(int ih)
    {
        binSaveInode(ih);
    }

    /* ************************************** */

    void soCloseInode(int ih)
    {
        binCloseInode(ih);
    }

    /* ************************************** */

    SOInode *soGetInodePointer(int ih)
    {
        return binGetInodePointer(ih);
    }

    /* ************************************** */

    uint32_t soGetInodeNumber(int ih)
    {
        return binGetInodeNumber(ih);
    }

    /* ************************************** */

};
