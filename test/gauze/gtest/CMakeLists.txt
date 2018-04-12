hunter_add_package(GTest)
find_package(GTest CONFIG REQUIRED)

hunter_add_package(cxxopts)
find_package(cxxopts CONFIG REQUIRED)

add_executable(gauze_gtest main.cpp)
target_link_libraries(gauze_gtest PUBLIC GTest::gtest cxxopts::cxxopts)

set(data_dir "${CMAKE_CURRENT_LIST_DIR}/data")

gauze_add_test(NAME gauze_gtest 
  COMMAND gauze_gtest
  "-a" # test short bool
  "--aint=314159"
  "--afloat=3.14159265359"
  "--astring=3.14159265359"
  "--afile=$<GAUZE_RESOURCE_FILE:${data_dir}/input.txt>"
  "--adir=$<GAUZE_RESOURCE_DIR:${data_dir}>"
)

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
