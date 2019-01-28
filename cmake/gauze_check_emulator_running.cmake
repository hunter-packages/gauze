function(gauze_check_emulator_running device_running_result)
  if("${ANDROID-SDK_ROOT}" STREQUAL "")
    message(FATAL_ERROR "Internal error")
  endif()
  if("${GAUZE_ANDROID_ADB}" STREQUAL "")
    message(FATAL_ERROR "Internal error")
  endif()

  set(cmd ${GAUZE_ANDROID_ADB} devices)
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

  if("${GAUZE_DEVICE_PORT}" STREQUAL "")
    message(FATAL_ERROR "Internal error")
  endif()

  string(REPLACE "\n" ";" output "${output}")
  string(REPLACE "\t" " " output "${output}")

  if(GAUZE_ANDROID_START_EMULATOR)
    # We expect that emulator created by Gauze, with name 'emulator-*'
    foreach(x ${output})
      string(REGEX MATCH "^emulator-${GAUZE_DEVICE_PORT}[ ]+device$" match "${x}")
      if(NOT "${match}" STREQUAL "")
        set(${device_running_result} TRUE PARENT_SCOPE)
        return()
      endif()
    endforeach()

    set(${device_running_result} FALSE PARENT_SCOPE)
    return()
  endif()

  # Emulator should be started by user
  foreach(x ${output})
    string(REGEX MATCH "[ ]+device$" match "${x}")
    if(NOT "${match}" STREQUAL "")
      set(${device_running_result} TRUE PARENT_SCOPE)
      return()
    endif()
  endforeach()

  message(FATAL_ERROR "Device not found, command to verify: ${cmd}")
endfunction()
