#include "dal.h"
#include "bin_dal.h"

#include <string.h>
#include <inttypes.h>

namespace sofs19
{
    /* ***************************************** */

    void soOpenSuperBlock()
    {
        binOpenSuperBlock();
    }

    /* ***************************************** */

    void soSaveSuperBlock()
    {
        binSaveSuperBlock();
    }

    /* ***************************************** */

    void soCloseSuperBlock()
    {
        binCloseSuperBlock();
    }

    /* ***************************************** */

    SOSuperBlock *soGetSuperBlockPointer()
    {
        return binGetSuperBlockPointer();
    }

    /* ***************************************** */
};
