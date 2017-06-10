hunter_add_package(Boost)
find_package(Boost CONFIG REQUIRED)

add_library(gauze gauze.cpp)
target_link_libraries(gauze PUBLIC Boost::boost)
