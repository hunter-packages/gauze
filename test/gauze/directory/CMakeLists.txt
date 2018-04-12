hunter_add_package(Boost COMPONENTS filesystem system)
find_package(Boost REQUIRED COMPONENTS filesystem system)

add_executable(gauze_directory main.cpp)
target_link_libraries(gauze_directory PRIVATE Boost::filesystem Boost::system)

set(data_dir "${CMAKE_CURRENT_LIST_DIR}/resdir")

gauze_add_test(
    NAME gauze_directory
    COMMAND
    gauze_directory
    arg1
    arg2
    arg3
    $<GAUZE_RESOURCE_DIR:${data_dir}>
    ${data_dir}/just_a_string.txt
    --directory=$<GAUZE_RESOURCE_DIR:${data_dir}>
)

if(WIN32 OR CYGWIN)
  set(new_path "${BOOST_ROOT}/lib")
  list(APPEND new_path $ENV{PATH})

  if(WIN32)
    string(REPLACE ";" "\;" new_path "${new_path}")
  elseif(CYGWIN)
    string(REPLACE ";" ":" new_path "${new_path}")
  else()
    message(FATAL_ERROR "Unreachable")
  endif()

  set_tests_properties(
      gauze_directory PROPERTIES ENVIRONMENT "PATH=${new_path}"
  )
endif()
