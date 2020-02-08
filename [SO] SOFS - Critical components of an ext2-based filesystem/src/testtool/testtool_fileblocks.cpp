#include "testtool.h"

#include "core.h"
#include "dal.h"
#include "fileblocks.h"

#include <string.h>

using namespace sofs19;

/* ******************************************** */

static FILE *fin = stdin;

/* ******************************************** */
/* get file block */
void getFileBlock(void)
{
    /* ask for inode number */
    promptMsg("Inode number: ");
    uint32_t in;
    fscanf(fin, "%u", &in);
    fPurge(fin);

    /* ask for file block index */
    promptMsg("File block index: ");
    uint32_t fbn;
    fscanf(fin, "%u", &fbn);
    fPurge(fin);

    /* open inode */
    uint32_t ih = soOpenInode(in);

    /* get file block */
    uint32_t bn = soGetFileBlock(ih, fbn);

    /* close inode */
    soCloseInode(ih);

    /* print result */
    if (bn != NullReference)
        resultMsg("Block number %u retrieved\n", bn);
    else
        resultMsg("Block number (nil) retrieved\n");
}

/* ******************************************** */
/* alloc file block */
void allocFileBlock(void)
{
    /* ask for inode number */
    promptMsg("Inode number: ");
    uint32_t in;
    fscanf(fin, "%u", &in);
    fPurge(fin);

    /* ask for file block index */
    promptMsg("File block index: ");
    uint32_t fbn;
    fscanf(fin, "%u", &fbn);
    fPurge(fin);

    /* open inode */
    uint32_t ih = soOpenInode(in);

    /* alloc file block */
    uint32_t bn = soAllocFileBlock(ih, fbn);

    /* save and close inode */
    soSaveInode(ih);
    soCloseInode(ih);

    /* print result */
    resultMsg("Block number %u allocated\n", bn);
}

/* ******************************************** */
/* free file blocks */
void freeFileBlocks(void)
{
    /* ask for inode number */
    promptMsg("Inode number: ");
    uint32_t in;
    fscanf(fin, "%u", &in);
    fPurge(fin);

    /* ask for file block index */
    promptMsg("First file block index: ");
    uint32_t ffbn;
    fscanf(fin, "%u", &ffbn);
    fPurge(fin);

    /* call function */
    /* open inode */
    uint32_t ih = soOpenInode(in);

    /* free blocks */
    soFreeFileBlocks(ih, ffbn);

    /* save and close inode */
    soSaveInode(ih);
    soCloseInode(ih);

    resultMsg("Operation done.\n");
}

/* ******************************************** */
/* read file block */
void readFileBlock(void)
{
    /* ask for inode number */
    promptMsg("Inode number: ");
    uint32_t in;
    fscanf(fin, "%u", &in);
    fPurge(fin);

    /* ask for file block index */
    promptMsg("File block index: ");
    uint32_t fbn;
    fscanf(fin, "%u", &fbn);
    fPurge(fin);

    /* open inode */
    uint32_t ih = soOpenInode(in);

    /* read block */
    char buf[BlockSize];
    memset(buf, 0, BlockSize);
    soReadFileBlock(ih, fbn, buf);

    /* close inode */
    soCloseInode(ih);

    /* show results */
    printBlockAsHex(buf);

    /* wait for ENTER */
return;

    promptMsg("\nPress ENTER to continue");
    if (quiet > 0)
        return;
    fscanf(fin, "%*[^\n]");
    fPurge(fin);
}

/* ******************************************** */
/* write file block */
void writeFileBlock(void)
{
    /* ask for inode number */
    promptMsg("Inode number: ");
    uint32_t in;
    fscanf(fin, "%u", &in);
    fPurge(fin);

    /* ask for file block index */
    promptMsg("File block index: ");
    uint32_t fbn;
    fscanf(fin, "%u", &fbn);
    fPurge(fin);

    /* ask for byte pattern */
    promptMsg("Byte pattern in hexadecimal: ");
    uint8_t bpx;
    fscanf(fin, "%hhx", &bpx);
    fPurge(fin);

    /* open inode */
    uint32_t ih = soOpenInode(in);

    /* read block */
    char buf[BlockSize];
    memset(buf, bpx, BlockSize);
    soWriteFileBlock(ih, fbn, buf);

    /* close inode */
    soSaveInode(ih);
    soCloseInode(ih);
}
