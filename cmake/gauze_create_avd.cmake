function(gauze_create_avd)
  if("${ANDROID-SDK_ROOT}" STREQUAL "")
    message(FATAL_ERROR "Internal error")
  endif()

  if("${GAUZE_DEVICE_NAME}" STREQUAL "")
    message(FATAL_ERROR "Internal error")
  endif()

  set(android_tool "${ANDROID-SDK_ROOT}/android-sdk/tools/android")

  set(cmd "${android_tool}" "list" "avd")
  execute_process(
      COMMAND ${cmd}
      RESULT_VARIABLE result
      OUTPUT_VARIABLE output
      ERROR_VARIABLE error
      OUTPUT_STRIP_TRAILING_WHITESPACE
      ERROR_STRIP_TRAILING_WHITESPACE
  )

  if(NOT result EQUAL 0)
    message(FATAL_ERROR "Command failed: ${cmd} (${result}, ${output}, ${error})")
  endif()

  string(REGEX MATCH "\n    Name: ${GAUZE_DEVICE_NAME}\n" avd_found "${output}")
  if(NOT "${avd_found}" STREQUAL "")
    message("AVD with name '${GAUZE_DEVICE_NAME}' already exist")
    return()
  endif()

  set(abi "${CMAKE_ANDROID_ARCH_ABI}")
  string(COMPARE EQUAL "${CMAKE_ANDROID_ARCH_ABI}" "armeabi" is_armeabi)
  if(is_armeabi)
    set(abi "armeabi-v7a")
  endif()

  string(TIMESTAMP timestamp)
  message("[${timestamp}] Creating AVD with name '${GAUZE_DEVICE_NAME}'")
  set(
      cmd
      ${android_tool}
      create
      avd
      "--name" "${GAUZE_DEVICE_NAME}"
      "--target" "android-${CMAKE_SYSTEM_VERSION}"
      "--abi" "${abi}"
  )
  execute_process(
      COMMAND ${CMAKE_COMMAND} -E echo no
      COMMAND ${cmd}
      RESULT_VARIABLE result
      OUTPUT_VARIABLE output
      ERROR_VARIABLE error
      OUTPUT_STRIP_TRAILING_WHITESPACE
      ERROR_STRIP_TRAILING_WHITESPACE
  )

  if(result EQUAL 0)
    string(TIMESTAMP timestamp)
    message("[${timestamp}] Done")
  else()
    message(FATAL_ERROR "Command failed: ${cmd} (${result}, ${output}, ${error})")
  endif()
endfunction()
