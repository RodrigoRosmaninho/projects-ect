add_library(core STATIC 
    exception.cpp
    probing.cpp
    binselection.cpp
    blockviews.cpp
)

add_executable(sizes sizes.cpp)
target_link_libraries(sizes rawdisk core)

add_executable(showblock showblock.cpp)
target_link_libraries(showblock rawdisk core)
