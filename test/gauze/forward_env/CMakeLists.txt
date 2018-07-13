add_executable(gauze_forward_env main.cpp)

gauze_add_test(
    NAME gauze_forward_env
    COMMAND gauze_forward_env
    FORWARD_ENV MY_GAUZE_VARIABLE_1 MY_GAUZE_VARIABLE_2
)

set_tests_properties(
    gauze_forward_env
    PROPERTIES
    ENVIRONMENT
    MY_GAUZE_VARIABLE_1=42
)
