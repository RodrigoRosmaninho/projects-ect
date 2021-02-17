set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_ROOT_DIR}/lib/grp)

add_library(grp_freelists STATIC
    grp_alloc_data_block.cpp
    grp_free_data_block.cpp
    grp_replenish_head_cache.cpp
    grp_deplete_tail_cache.cpp
    grp_alloc_inode.cpp
    grp_free_inode.cpp
)

