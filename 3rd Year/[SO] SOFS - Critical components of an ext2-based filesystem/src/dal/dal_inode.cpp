#include "dal.h"
#include "bin_dal.h"

namespace sofs19
{
    bool soCheckInodeAccess(int ih, int access)
    {
        return binCheckInodeAccess(ih, access);
    }

};
