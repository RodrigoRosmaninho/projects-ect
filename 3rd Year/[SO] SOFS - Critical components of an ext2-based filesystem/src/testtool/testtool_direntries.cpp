#include "testtool.h"

#include "core.h"
#include "dal.h"
#include "direntries.h"

#include <string.h>

using namespace sofs19;

/* ******************************************** */

static FILE *fin = stdin;

/* ******************************************** */
/* check directory emptiness */
void checkDirectoryEmptiness()
{
    /* ask for inode number */
    promptMsg("Parent inode number: ");
    uint32_t in;
    fscanf(fin, "%u", &in);
    fPurge(fin);

    /* open parent inode */
    int ih = soOpenInode(in);

    /* call function */
    bool is_empty = soCheckDirEmpty(ih);

    /* print result */
    if (is_empty)
        resultMsg("Directory is empty\n");
    else
        resultMsg("Directory is NOT empty\n");
}

/* ******************************************** */
/* get direntry */
void getDirEntry()
{
    /* ask for inode number */
    promptMsg("Parent inode number: ");
    uint32_t pin;
    fscanf(fin, "%u", &pin);
    fPurge(fin);

    /* ask for direntry name */
    promptMsg("Direntry name: ");
    char name[100];
    name[0] = '\0';
    fscanf(fin, "%[^\n]", name);
    fPurge(fin);

    /* open parent inode */
    int pih = soOpenInode(pin);

    /* call function */
    uint32_t cin = soGetDirEntry(pih, name);

    /* close inode */
    soCloseInode(pih);

    /* print result */
    if (cin == NullReference)
        resultMsg("Entry \"%s\" does not exist\n", name);
    else
        resultMsg("Child inode number = %u.\n", cin);
}

/* ******************************************** */
/* add direntry */
void addDirEntry()
{
    /* ask for parent inode number */
    promptMsg("Parent inode number: ");
    uint32_t pin;
    fscanf(fin, "%u", &pin);
    fPurge(fin);

    /* ask for direntry name */
    promptMsg("Direntry name: ");
    char name[100];
    name[0] = '\0';
    fscanf(fin, "%[^\n]", name);
    fPurge(fin);

    /* ask for child inode number */
    promptMsg("Child inode number: ");
    uint32_t cin;
    fscanf(fin, "%u", &cin);
    fPurge(fin);

    /* open parent and child inodes */
    int pih = soOpenInode(pin);

    /* call function */
    soAddDirEntry(pih, name, cin);

    /* close inodes */
    soSaveInode(pih);
    soCloseInode(pih);

    /* print result */
    resultMsg("Direntry added.\n");
}

/* ******************************************** */
/* rename direntry */
void renameDirEntry()
{
    /* ask for parent inode number */
    promptMsg("Parent inode number: ");
    uint32_t pin;
    fscanf(fin, "%u", &pin);
    fPurge(fin);

    /* ask for direntry name */
    promptMsg("Direntry name: ");
    char name[100];
    name[0] = '\0';
    fscanf(fin, "%[^\n]", name);
    fPurge(fin);

    /* ask for new direntry name */
    promptMsg("New direntry name: ");
    char newname[100];
    newname[0] = '\0';
    fscanf(fin, "%[^\n]", newname);
    fPurge(fin);

    /* open parent inode */
    int pih = soOpenInode(pin);

    /* call function */
    soRenameDirEntry(pih, name, newname);

    /* close inode */
    soSaveInode(pih);
    soCloseInode(pih);

    /* print result */
    resultMsg("Direntry renamed.\n");
}

/* ******************************************** */
/* delete direntry */
void deleteDirEntry()
{
    /* ask for inode number */
    promptMsg("Parent inode number: ");
    uint32_t pin;
    fscanf(fin, "%u", &pin);
    fPurge(fin);

    /* ask for direntry name */
    promptMsg("Direntry name: ");
    char name[100];
    name[0] = '\0';
    fscanf(fin, "%[^\n]", name);
    fPurge(fin);

#if 0
    /* ask for clean or non clean deletion */
    promptMsg("Clean entry (y/N): ");
    char answer[100];
    answer[0] = '\0';
    fscanf(fin, "%[^\n]", answer);
    bool clean = (strcasecmp(answer, "y") == 0) || (strcasecmp(answer, "yes") == 0);

    fPurge(fin);
#endif

    /* open parent inode */
    int pih = soOpenInode(pin);

    /* call function */
    uint32_t cin = soDeleteDirEntry(pih, name);

    /* close inode */
    soSaveInode(pih);
    soCloseInode(pih);

    /* print result */
    resultMsg("Child inode number = %u.\n", cin);
}

/* ******************************************** */
/* traverse path */
void traversePath()
{
    /* ask for PATH */
    promptMsg("path: ");
    char path[500];
    path[0] = '\0';
    fscanf(fin, "%[^\n]", path);
    fPurge(fin);

    /* call function */
    uint32_t in = soTraversePath(path);

    /* print result */
    resultMsg("inode number = %u\n", in);
}
