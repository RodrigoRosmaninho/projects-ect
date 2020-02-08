
/*
 *  \author Artur Pereira - 2007-2009, 2016-2019
 *  \author Miguel Oliveira e Silva - 2009, 2017
 *  \author António Rui Borges - 2010-2012
 */

#define  __STDC_FORMAT_MACROS
#include <inttypes.h>
#include <stdio.h>
#include <stdbool.h>
#include <time.h>
#include <sys/stat.h>
#include <string.h>

#include <iostream>

#include "core.h"

namespace sofs19
{

    /* ********************************************************* */

    void printBlockAsHex(void *buf, uint32_t off)
    {
        /* cast buf to appropriate type */
        unsigned char *byte = (unsigned char *)buf;

        /* print cluster */
        for (uint32_t i = 0; i < BlockSize; i++)
        {
            if ((i & 0x1f) == 0)
                printf("%4.4x:", i + off);
            /* print byte */
            printf(" %.2x", byte[i]);
            /* terminate present line, if required */
            if ((i & 0x1f) == 0x1f)
                printf("\n");
        }
    }

    /* ********************************************************* */

    void printBlockAsAscii(void *buf, uint32_t off)
    {
        /* cast buf to appropriate type */
        unsigned char *c = (unsigned char *)buf;

        /* print cluster */
        char line[256];         /* line to be printed */
        char *p_line = line;    /* pointer to a character in the line */
        for (uint32_t i = 0; i < BlockSize; i++)
        {
            if ((i & 0x1f) == 0)
            {
                printf("%4.4d:", i + off);
                p_line = line;
            }
            /* add character to the line */
            switch (c[i])
            {
                case '\a':
                    p_line += sprintf(p_line, " \\a");
                    break;
                case '\b':
                    p_line += sprintf(p_line, " \\b");
                    break;
                case '\f':
                    p_line += sprintf(p_line, " \\f");
                    break;
                case '\n':
                    p_line += sprintf(p_line, " \\n");
                    break;
                case '\r':
                    p_line += sprintf(p_line, " \\r");
                    break;
                case '\t':
                    p_line += sprintf(p_line, " \\t");
                    break;
                case '\v':
                    p_line += sprintf(p_line, " \\v");
                    break;
                default:
                    if ((c[i] >= ' ') && (c[i] != 0x7F) && (c[i] != 0x8F))
                        p_line += sprintf(p_line, " %c ", c[i]);
                    else
                        p_line += sprintf(p_line, " %.2x", c[i]);
            }
            /* terminate and print present line, if required */
            if ((i & 0x1f) == 0x1f)
            {
                *p_line = '\0';
                printf("%s\n", line);
            }
        }
    }

    /* ********************************************************* */

    void printSuperBlock(void *buf)
    {
        /* cast buf to appropriate type */
        SOSuperBlock *sbp = (SOSuperBlock *) buf;

        /* header */
        printf("Header:\n");
        printf("   Magic number: 0x%04x\n", sbp->magic);
        printf("   Version number: 0x%04x\n", sbp->version);
        printf("   Volume name: \"%-s\"\n", sbp->name);
        printf("   Properly unmounted: %s\n", (sbp->mntstat == 1) ? "yes" : "no");
        printf("   Number of mounts: %u\n", sbp->mntcnt);
        printf("   Total number of blocks in the device: %u\n", sbp->ntotal);
        //printf("\n");

        /* ----------------------------------------------------- */

        /* inodes' metadata */
        printf("Inodes' metadata:\n");
        printf("   Number of blocks of the inode table: %u\n", sbp->it_size);
        printf("   Total number of inodes: %u\n", sbp->itotal);
        printf("   Number of free inodes: %u\n", sbp->ifree);
        printf("   Head of list of free inodes: ");
        if (sbp->ihead == NullReference)
            printf("(nil)\n");
        else
            printf("%" PRIu32 "\n", sbp->ihead);
        printf("   Tail of list of free inodes: ");
        if (sbp->itail == NullReference)
            printf("(nil)\n");
        else
            printf("%" PRIu32 "\n", sbp->itail);

        /* ----------------------------------------------------- */

        /* blocks' metadata */
        printf("Data blocks' metadata:\n");
        printf("   First block of the data zone: %u\n", sbp->dz_start);
        printf("   Total number of data blocks: %u\n", sbp->dz_total);
        printf("   Number of free data blocks: %u\n", sbp->dz_free);

        printf("   Head reference data block: ");
        if (sbp->head_blk == NullReference)
            printf("(nil)\n");
        else
            printf("%" PRIu32 "\n", sbp->head_blk);
        printf("   First occupied position on head reference data block: ");
        if (sbp->head_idx == NullReference)
            printf("(nil)\n");
        else
            printf("%" PRIu32 "\n", sbp->head_idx);

        printf("   Tail reference data block: ");
        if (sbp->tail_blk == NullReference)
            printf("(nil)\n");
        else
            printf("%" PRIu32 "\n", sbp->tail_blk);
        printf("   First empty position on tail reference data block: ");
        if (sbp->tail_idx == NullReference)
            printf("(nil)\n");
        else
            printf("%" PRIu32 "\n", sbp->tail_idx);

        /* ----------------------------------------------------- */

        /* Head cache' contents */
        printf("   Head cache:\n");
        printf("      Index of the first occupied cache position: ");
        if (sbp->head_cache.idx == HEAD_CACHE_SIZE)
            printf("(nil)\n");
        //printf("(%u)\n", sbp->head_cache.idx);
        else
            printf("%u\n", sbp->head_cache.idx);
        printf("      Cache contents:");
        printf("        ");
        for (uint32_t i = 0; i < HEAD_CACHE_SIZE; i++)
        {
            if ((i % 10) == 0)
                printf("\n        ");
            if (sbp->head_cache.ref[i] == NullReference)
                printf(" (nil)");
            else
                printf(" %u", sbp->head_cache.ref[i]);
        }
        printf("\n");

        printf("   Tail cache:\n");
        printf("      Index of the first empty cache position: ");
        if (sbp->tail_cache.idx == TAIL_CACHE_SIZE)
            printf("(nil)\n");
        //printf("(%u)\n", sbp->tail_cache.idx);
        else
            printf("%u\n", sbp->tail_cache.idx);
        printf("      Cache contents:");
        printf("        ");
        for (uint32_t i = 0; i < TAIL_CACHE_SIZE; i++)
        {
            if ((i % 10) == 0)
                printf("\n        ");
            if (sbp->tail_cache.ref[i] == NullReference)
                printf(" (nil)");
            else
                printf(" %u", sbp->tail_cache.ref[i]);
        }
        printf("\n");

        /* ----------------------------------------------------- */

    }

    /* ********************************************************* */

    /* \brief Bit pattern description of the mode field in the inode data type */
    static const char *inodetypes[] = {
        "",
        " and INVALID_001",
        " and INVALID-002",
        " and INVALID_003",
        "directory",
        " and INVALID-005",
        " and INVALID-006",
        " and INVALID_007",
        "regular file",
        " and INVALID_011",
        "symlink",
        " and INVALID_013",
        " and INVALID-014",
        " and INVALID-015",
        " and INVALID-016",
        " and INVALID-017"
    };

    static void printInode(void *buf, uint32_t in, bool showtimes = true)
    {
        SOInode *ip = (SOInode *) buf;

        /* print inode number */
        printf("Inode #");
        if (in == NullReference)
            printf("(nil)\n");
        else
            printf("%u\n", in);

        /* decouple and print mode field */
        bool not_in_use = (ip->mode & INODE_FREE) == INODE_FREE;
        uint32_t typebits = (ip->mode & S_IFMT) >> 12;
        printf("type = %s%s, ", not_in_use ? "free" : "", inodetypes[typebits]);

        uint32_t permbits = ip->mode & (S_IRWXU | S_IRWXG | S_IRWXO);
        char perm[10] = "rwxrwxrwx";    /* access permissions array */
        for (int i = 0; i < 9; i++)
        {
            if ((permbits % 2) == 0)    // LSB is zero ?
            {
                perm[8 - i] = '-';
            }
            permbits >>= 1;
        }
        printf("permissions = %s, ", perm);

        /* print reference count */
        printf("lnkcnt = %" PRIu16 ", ", ip->lnkcnt);

        /* print owner and group IDs */
        printf("owner = %u, group = %u\n", ip->owner, ip->group);

        /* print file size in bytes and in clusters */
        printf("size in bytes = %u, block count = %u", ip->size, ip->blkcnt);

        /* print times and/or next pointer */
        if (not_in_use)
        {
            printf(", next = ");
            if (ip->next == NullReference)
                printf("(nil)\n");
            else
                printf("%" PRIu32 "\n", ip->next);
        }
        else
        {
            printf("\n");
        }

        if (showtimes and not not_in_use)
        {
            char timebuf[30];
            time_t t = ip->atime;
            ctime_r(&t, timebuf);
            timebuf[strlen(timebuf) - 1] = '\0';
            printf("atime = %s, ", timebuf);
            t = ip->mtime;
            ctime_r(&t, timebuf);
            timebuf[strlen(timebuf) - 1] = '\0';
            printf("mtime = %s, ", timebuf);
            t = ip->ctime;
            ctime_r(&t, timebuf);
            timebuf[strlen(timebuf) - 1] = '\0';
            printf("ctime = %s\n", timebuf);
        }

        /* print direct references */
        printf(" d[*] = {");
        for (int i = 0; i < N_DIRECT; i++)
        {
            if (i > 0)
                printf(" ");
            if (ip->d[i] == NullReference)
                printf("(nil)");
            else
                printf("%" PRIu32 "", ip->d[i]);
        }
        printf("}\n");

        /* print single indirect references */
        printf("i1[*] = {");
        for (int i = 0; i < N_INDIRECT; i++)
        {
            if (i > 0)
                printf(" ");
            if (ip->i1[i] == NullReference)
                printf("(nil)");
            else
                printf("%" PRIu32 "", ip->i1[i]);
        }
        printf("}\n");

        /* print double indirect reference */
        printf("i2[*] = {");
        for (int i = 0; i < N_DOUBLE_INDIRECT; i++)
        {
            if (i > 0)
                printf(" ");
            if (ip->i2[i] == NullReference)
                printf("(nil)");
            else
                printf("%" PRIu32 "", ip->i2[i]);
        }
        printf("}\n");

        printf("----------------\n");
    }

    /* ********************************************************* */

    void printBlockOfInodes(void *buf, uint32_t off, bool showtimes)
    {
        /* cast buf to appropriate type */
        SOInode *inode = (SOInode *) buf;

        /* treat each inode stored in the block separately */
        for (uint32_t i = 0; i < IPB; i++)
            printInode(&inode[i], i + off, showtimes);
    }

    /* ********************************************************* */

    void printBlockOfDirents(void *buf, uint32_t off)
    {
        /* get dirents per cluster */
        uint32_t dpb = BlockSize / sizeof (SODirEntry);

        /* cast buf to appropriate type */
        SODirEntry *dir = (SODirEntry *) buf;

        /* print */
        for (uint32_t i = 0; i < dpb; i++)
        {
            printf("%-*.*s ", SOFS19_MAX_NAME, SOFS19_MAX_NAME, dir[i].name);
            if (dir[i].in == NullReference)
                printf("(nil)\n");
            else
                printf("%.10" PRIu32 "\n", dir[i].in);
        }
    }

    /* ********************************************************* */

    void printBlockOfRefs(void *buf, uint32_t off)
    {
        /* get refs per block */
        uint32_t rpb = BlockSize / sizeof (uint32_t);

        /* cast buf to appropriate type */
        uint32_t *ref = (uint32_t *) buf;

        for (uint32_t i = 0; i < rpb; i++)
        {
            if ((i & 0x07) == 0)
                printf("%4.4d:", i + off);
            /* print reference to a cluster */
            if (ref[i] == NullReference)
                printf("   (nil)   ");
            else
                printf(" %.10" PRIu32, ref[i]);
            /* terminate present line, if required */
            if (((i & 0x07) == 0x07) || (i == (rpb - 1)))
                printf("\n");
        }
    }

    /* ********************************************************* */

};
