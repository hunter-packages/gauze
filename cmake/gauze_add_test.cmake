cmake_minimum_required(VERSION 3.1)

include(CMakeParseArguments) # cmake_parse_arguments

include(gauze_get_all_dependencies)
include(gauze_start_android_emulator)

set(GAUZE_ADD_TEST_SELF_DIR "${CMAKE_CURRENT_LIST_DIR}")

function(gauze_add_test)
  set(optional "")
  set(one NAME)
  set(multiple COMMAND FORWARD_ENV)

  # * x_NAME
  # * x_COMMAND
  # * x_FORWARD_ENV
  cmake_parse_arguments(x "${optional}" "${one}" "${multiple}" "${ARGV}")

  string(COMPARE NOTEQUAL "${x_UNPARSED_ARGUMENTS}" "" has_unparsed)
  if(has_unparsed)
    message(FATAL_ERROR "Unparsed arguments: ${x_UNPARSED_ARGUMENTS}")
  endif()

  if("${x_NAME}" STREQUAL "")
    message(FATAL_ERROR "NAME required")
  endif()

  if("${x_COMMAND}" STREQUAL "")
    message(FATAL_ERROR "COMMAND required")
  endif()

  list(GET x_COMMAND 0 APP_TARGET)
  if(NOT TARGET "${APP_TARGET}")
    message(
        FATAL_ERROR
        "Expected executable target as first argument, but got: ${APP_TARGET}"
    )
  endif()

  if(TARGET gauze)
    add_library(gauze::gauze ALIAS gauze)
  else()
    find_package(gauze CONFIG REQUIRED)
  endif()

  target_link_libraries("${APP_TARGET}" PUBLIC gauze::gauze)

  list(REMOVE_AT x_COMMAND 0)
  set(APP_ARGUMENTS ${x_COMMAND})

  set(
      script_path
      "${CMAKE_CURRENT_BINARY_DIR}/_3rdParty/gauze_test/${x_NAME}.cmake"
  )

  set(RESOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}")

  if(EXISTS "${CMAKE_TOOLCHAIN_FILE}")
    get_filename_component(toolchain_suffix "${CMAKE_TOOLCHAIN_FILE}" NAME_WE)
  else()
    set(toolchain_suffix "default")
  endif()

  if(ANDROID)
    hunter_add_package(Android-SDK)
    set(ADB_COMMAND "${ANDROID-SDK_ROOT}/android-sdk/platform-tools/adb")

    set(
        GAUZE_ANDROID_DEVICE_TESTING_ROOT
        "/data/local/tmp"
        CACHE
        STRING
        "Android device testing root directory"
    )
    set(TESTING_DIR "${GAUZE_ANDROID_DEVICE_TESTING_ROOT}/${PROJECT_NAME}/${toolchain_suffix}")

    if(GAUZE_ANDROID_USE_EMULATOR)
      gauze_start_android_emulator()
    endif()

    # Use:
    # * ADB_COMMAND
    # * APP_TARGET
    # * APP_ARGUMENTS
    # * TESTING_DIR
    # * RESOURCE_DIR
    # * GAUZE_ANDROID_USE_EMULATOR
    # * x_FORWARD_ENV
    configure_file(
        "${GAUZE_ADD_TEST_SELF_DIR}/templates/AndroidTest.cmake.in"
        "${script_path}"
        @ONLY
    )

    gauze_get_all_dependencies(TARGET "${APP_TARGET}" IGNORE "" RESULT deps)
    set(libs "")
    foreach(x ${deps})
      get_target_property(type "${x}" TYPE)
      if("${type}" STREQUAL "SHARED_LIBRARY")
        if(NOT "${libs}" STREQUAL "")
          set(libs "${libs},")
        endif()
        set(libs "${libs}$<TARGET_FILE:${x}>")
      endif()
    endforeach()

    add_test(
        NAME "${x_NAME}"
        COMMAND
            "${CMAKE_COMMAND}"
            "-DAPP_SOURCE=$<TARGET_FILE:${APP_TARGET}>"
            "-DLINKED_LIBS=${libs}"
            -P
            "${script_path}"
    )
  elseif(IOS)
    set(ios_deploy_prog_name "ios-deploy")
    find_program(ios_deploy "${ios_deploy_prog_name}")
    if(ios_deploy)
      # If program is found set full path as a default value for GAUZE_IOS_DEPLOY
      set(default_ios_deploy "${ios_deploy}")
    else()
      # Program not found, set default value to 'ios-deploy'
      set(default_ios_deploy "${ios_deploy_prog_name}")
    endif()

    set(
        GAUZE_IOS_DEPLOY
        "${default_ios_deploy}"
        CACHE
        FILEPATH
        "Path to 'ios-deploy' executable (https://github.com/phonegap/ios-deploy)"
    )

    set(
        GAUZE_IOS_UPLOAD_ROOT
        "Documents"
        CACHE
        STRING
        "iOS root directory for uploads"
    )

    set(
        GAUZE_IOS_BUNDLE_IDENTIFIER
        "io.rtfd.gauze"
        CACHE
        STRING
        "Bundle ID template for iOS test targets"
    )

    set(BUNDLE_ID "${GAUZE_IOS_BUNDLE_IDENTIFIER}.${toolchain_suffix}.${APP_TARGET}")

    # '_' is an illegal character
    string(REPLACE "_" "-" BUNDLE_ID "${BUNDLE_ID}")

    set_target_properties(
        "${APP_TARGET}"
        PROPERTIES
        MACOSX_BUNDLE_GUI_IDENTIFIER "${BUNDLE_ID}"
    )

    # Use:
    # * GAUZE_IOS_DEPLOY
    # * APP_ARGUMENTS
    # * RESOURCE_DIR
    # * BUNDLE_ID
    configure_file(
        "${GAUZE_ADD_TEST_SELF_DIR}/templates/iOSTest.cmake.in"
        "${script_path}"
        @ONLY
    )

    add_test(
        NAME "${x_NAME}"
        COMMAND
            "${CMAKE_COMMAND}"
            "-DAPP_SOURCE=$<TARGET_FILE:${APP_TARGET}>"
            -P
            "${script_path}"
    )
  else()
    set(arguments)
    foreach(x ${APP_ARGUMENTS})
      # Use resources as is
      string(REGEX REPLACE "\\$<GAUZE_RESOURCE_FILE:\(.*\)>$" "\\1" x "${x}")
      string(REGEX REPLACE "\\$<GAUZE_RESOURCE_DIR:\(.*\)>$" "\\1" x "${x}")
      list(APPEND arguments "${x}")
    endforeach()
    add_test(NAME "${x_NAME}" COMMAND ${APP_TARGET} ${arguments})
  endif()
endfunction()
