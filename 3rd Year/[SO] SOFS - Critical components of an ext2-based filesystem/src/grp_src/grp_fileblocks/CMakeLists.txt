set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_ROOT_DIR}/lib/grp)

add_library(grp_fileblocks STATIC
        grp_alloc_fileblock.cpp
        grp_free_fileblocks.cpp
        grp_get_fileblock.cpp
        grp_read_fileblock.cpp
        grp_write_fileblock.cpp
)

