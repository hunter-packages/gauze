add_executable(gauze_deps main.cpp)

target_link_libraries(gauze_deps PUBLIC gauze_deplib)

gauze_add_test(NAME gauze_deps COMMAND gauze_deps)

if(WIN32 OR CYGWIN)
  set(new_path "")
  foreach(target gauze_deplib)
    list(APPEND new_path $<TARGET_FILE_DIR:${target}>)
  endforeach()
  list(APPEND new_path $ENV{PATH})

  if(WIN32)
    string(REPLACE ";" "\;" new_path "${new_path}")
  elseif(CYGWIN)
    string(REPLACE ";" ":" new_path "${new_path}")
  else()
    message(FATAL_ERROR "Unreachable")
  endif()

  set_tests_properties(
      gauze_deps PROPERTIES ENVIRONMENT "PATH=${new_path}"
  )
endif()
