set(
    HUNTER_CACHE_SERVERS
    "https://github.com/ingenue/hunter-cache"
    CACHE
    STRING
    "Default cache server"
)

# https://docs.travis-ci.com/user/environment-variables/#Default-Environment-Variables
string(COMPARE EQUAL "$ENV{TRAVIS}" "true" is_travis)

# https://www.appveyor.com/docs/environment-variables/
string(COMPARE EQUAL "$ENV{APPVEYOR}" "True" is_appveyor)

string(COMPARE EQUAL "$ENV{GITHUB_USER_PASSWORD}" "" password_is_empty)

if((is_travis OR is_appveyor) AND NOT password_is_empty)
  option(HUNTER_RUN_UPLOAD "Upload cache binaries" OFF) # FIXME
endif()

set(
    HUNTER_PASSWORDS_PATH
    "${CMAKE_CURRENT_LIST_DIR}/gauze_upload_passwords.cmake"
    CACHE
    FILEPATH
    "Hunter passwords"
)

message("HUNTER_RUN_UPLOAD: ${HUNTER_RUN_UPLOAD}")
