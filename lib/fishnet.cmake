include(FetchContent)
set(FISHNET_TEST OFF)
set(FISHNET_APPS ON)
set(FISHNET_EXAMPLES OFF)
set(FISHNET_TEST_LIB OFF)
FetchContent_Declare(fishnet
    GIT_REPOSITORY https://github.com/DescartesResearch/fishnet.git
    GIT_TAG 2.0.1
)
FetchContent_MakeAvailable(fishnet)
