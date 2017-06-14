cmake_minimum_required(VERSION 3.3) # IN_LIST

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.19.10.tar.gz"
    SHA1 "73b5a5253b75d5ed79c89242c167ca1f94386621"
)

project(gauze VERSION 0.1)

option(GAUZE_BUILD_TESTS "Build tests" ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(gauze_add_test)

# For '#include <gauze/deplib/Deplib.hpp>'
include_directories("${CMAKE_CURRENT_LIST_DIR}/test")

####
# Installation (https://github.com/forexample/package-example)

set(config_install_dir "lib/cmake/${PROJECT_NAME}")
set(generated_dir "${CMAKE_CURRENT_BINARY_DIR}/generated")
set(version_config "${generated_dir}/${PROJECT_NAME}ConfigVersion.cmake")
set(project_config "${generated_dir}/${PROJECT_NAME}Config.cmake")
set(TARGETS_EXPORT_NAME "${PROJECT_NAME}Targets")
set(namespace "${PROJECT_NAME}::")

include(CMakePackageConfigHelpers)

# Note: PROJECT_VERSION is used as a VERSION
write_basic_package_version_file(
    "${version_config}" COMPATIBILITY SameMajorVersion
)

# Use variables:
#   * TARGETS_EXPORT_NAME
#   * PROJECT_NAME
configure_package_config_file(
    "cmake/Config.cmake.in"
    "${project_config}"
    INSTALL_DESTINATION "${config_install_dir}"
)

install(
    FILES "${project_config}" "${version_config}"
    DESTINATION "${config_install_dir}"
)

install(
    EXPORT "${TARGETS_EXPORT_NAME}"
    NAMESPACE "${namespace}"
    DESTINATION "${config_install_dir}"
)

install(
    FILES
    cmake/gauze_check_emulator_running.cmake
    cmake/gauze_get_all_dependencies.cmake
    cmake/gauze_start_android_emulator.cmake
    cmake/gauze_add_test.cmake
    cmake/gauze_create_avd.cmake
    cmake/gauze_run_start_script.cmake
    DESTINATION cmake/${PROJECT_NAME}
)

install(
    FILES
    cmake/templates/AndroidTest.cmake.in
    cmake/templates/iOSTest.cmake.in
    cmake/templates/start-emulator.sh.in
    DESTINATION cmake/${PROJECT_NAME}/templates
)

add_subdirectory(lib/gauze)

if(GAUZE_BUILD_TESTS)
  if("$ENV{TRAVIS}" STREQUAL "true" AND IOS)
    # Do not run tests (just build)
  else()
    enable_testing()
  endif()
  add_subdirectory(test/gauze)
endif()
