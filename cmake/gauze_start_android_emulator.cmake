include(gauze_check_emulator_running)
include(gauze_create_avd)
include(gauze_run_start_script)

function(gauze_start_android_emulator)
  hunter_add_package(Android-SDK) # ANDROID-SDK_ROOT

  set(GAUZE_DEVICE_PORT 5678)
  set(GAUZE_DEVICE_NAME "gauze_android-${CMAKE_SYSTEM_VERSION}_${CMAKE_ANDROID_ARCH_ABI}")
  set(GAUZE_ANDROID_ADB "${ANDROID-SDK_ROOT}/android-sdk/platform-tools/adb")
  set(GAUZE_ANDROID_EMULATOR "${ANDROID-SDK_ROOT}/android-sdk/tools/emulator")

  gauze_check_emulator_running(result)
  if(result)
    message("Device already is running")
    return()
  endif()

  gauze_create_avd()
  gauze_run_start_script()

  gauze_check_emulator_running(result)
  if(NOT result)
    message(FATAL_ERROR "Device is not running")
  endif()
endfunction()
