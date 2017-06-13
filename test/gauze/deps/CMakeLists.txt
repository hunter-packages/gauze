add_executable(gauze_deps main.cpp)

target_link_libraries(gauze_deps PUBLIC gauze_deplib)

gauze_add_test(NAME gauze_deps COMMAND gauze_deps)
