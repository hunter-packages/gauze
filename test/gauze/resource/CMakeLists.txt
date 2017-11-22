add_executable(gauze_resource main.cpp)

set(data_dir "${CMAKE_CURRENT_LIST_DIR}/data")

gauze_add_test(
    NAME gauze_resource
    COMMAND
    gauze_resource
    arg1
    arg2
    arg3
    $<GAUZE_RESOURCE_FILE:${data_dir}/input.txt>
    ${data_dir}/just_a_string.txt
    --input=$<GAUZE_RESOURCE_FILE:${data_dir}/input.txt>
)
