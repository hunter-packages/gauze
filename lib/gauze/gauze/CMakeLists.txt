hunter_add_package(Boost)
find_package(Boost CONFIG REQUIRED)

add_library(gauze gauze.cpp)
target_link_libraries(gauze PUBLIC Boost::boost)

install(
    TARGETS gauze
    EXPORT "${TARGETS_EXPORT_NAME}"
    LIBRARY DESTINATION "lib"
    ARCHIVE DESTINATION "lib"
    RUNTIME DESTINATION "bin"
    INCLUDES DESTINATION "include"
)
