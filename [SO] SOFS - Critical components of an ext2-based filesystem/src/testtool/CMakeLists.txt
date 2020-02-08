set(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} -L${PROJECT_ROOT_DIR}/lib/bin")
set(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} -L${PROJECT_ROOT_DIR}/lib/grp")
set(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} -Wl,--start-group")

add_executable(testtool
        testtool.cpp
        testtool_msgs.cpp
        testtool_core.cpp
        testtool_freelists.cpp
        testtool_fileblocks.cpp
        testtool_direntries.cpp
        testtool_inodeattrs.cpp
)

target_link_libraries(testtool
       direntries 
       grp_direntries
       bin_direntries
       fileblocks
       grp_fileblocks
       bin_fileblocks
       freelists
       grp_freelists
       bin_freelists
       dal bin_dal
       core
       rawdisk
)
