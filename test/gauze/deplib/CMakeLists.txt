add_library(gauze_deplib Deplib.cpp Deplib.hpp)

set(LOCAL_GENERATED_INCLUDE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/generated)

target_include_directories(
    gauze_deplib
    PUBLIC
    "$<BUILD_INTERFACE:${LOCAL_GENERATED_INCLUDE_DIRECTORY}>"
)

set(
    export_header
    "${LOCAL_GENERATED_INCLUDE_DIRECTORY}/GAUZE_DEPLIB_EXPORT.h"
)

include(GenerateExportHeader)
generate_export_header(gauze_deplib EXPORT_FILE_NAME ${export_header})
