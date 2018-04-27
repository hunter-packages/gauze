add_subdirectory(simple)
add_subdirectory(args)
add_subdirectory(resource)

if(ANDROID AND BUILD_SHARED_LIBS)
  # Boost.filesystem is broken, trying to link '-lrt'
else()
  add_subdirectory(directory)
endif()

add_subdirectory(deplib) # before 'deps'
add_subdirectory(deps)
add_subdirectory(gtest)
