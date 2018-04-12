hunter_add_package(GTest)
find_package(GTest CONFIG REQUIRED)

add_executable(gauze_gtest main.cpp)
target_link_libraries(gauze_gtest PUBLIC GTest::gtest)

gauze_add_test(NAME gauze_gtest COMMAND gauze_gtest)

if(WIN32 OR CYGWIN)
  set(new_path "${GTEST_ROOT}/bin")
  list(APPEND new_path $ENV{PATH})

  if(WIN32)
    string(REPLACE ";" "\;" new_path "${new_path}")
  elseif(CYGWIN)
    string(REPLACE ";" ":" new_path "${new_path}")
  else()
    message(FATAL_ERROR "Unreachable")
  endif()

  set_tests_properties(
      gauze_gtest PROPERTIES ENVIRONMENT "PATH=${new_path}"
  )
endif()
