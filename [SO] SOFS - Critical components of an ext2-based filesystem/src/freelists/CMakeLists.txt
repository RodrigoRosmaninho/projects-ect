add_library(freelists STATIC
    alloc_data_block.cpp
    free_data_block.cpp
    replenish_head_cache.cpp
    deplete_tail_cache.cpp
    alloc_inode.cpp
    free_inode.cpp
)

