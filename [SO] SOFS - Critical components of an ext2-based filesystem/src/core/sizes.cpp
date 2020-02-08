#include <iostream>

#include "core.h"

using namespace std;
using namespace sofs19;

int main(void)
{
    cout <<
        "BlockSize: " << BlockSize << endl <<
        "sizeof(SOSuperBlock): " << sizeof(SOSuperBlock) << endl <<
        "sizeof(SOInode): " << sizeof(SOInode) << endl <<
        "sizeof(SODirEntry): " << sizeof(SODirEntry) << endl <<
        "IPB (inodes per block): " << IPB << endl <<
        "DPB (direntries per block): " << DPB << endl <<
        "RPB references per block): " << RPB << endl;

    return 0;
}
