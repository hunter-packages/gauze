hunter_add_package(Boost)
find_package(Boost CONFIG REQUIRED)

# On OSX and Windows you can't have shared library with undefined symbol
add_library(gauze STATIC gauze.cpp)
target_link_libraries(gauze PUBLIC Boost::boost)

set_target_properties(gauze PROPERTIES POSITION_INDEPENDENT_CODE TRUE)

install(
    TARGETS gauze
    EXPORT "${TARGETS_EXPORT_NAME}"
    LIBRARY DESTINATION "lib"
    ARCHIVE DESTINATION "lib"
    RUNTIME DESTINATION "bin"
    INCLUDES DESTINATION "include"
)
