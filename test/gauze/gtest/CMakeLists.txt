hunter_add_package(GTest)
find_package(GTest CONFIG REQUIRED)

add_executable(gauze_gtest main.cpp)
target_link_libraries(gauze_gtest PUBLIC GTest::gtest)

gauze_add_test(NAME gauze_gtest COMMAND gauze_gtest)
