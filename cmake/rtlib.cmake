# Flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall ${TARGET_FLAGS} -ffunction-sections -fdata-sections")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall ${TARGET_FLAGS}")
set(CMAKE_C_FLAGS_RELEASE "-Os")
set(CMAKE_CXX_FLAGS_RELEASE "-Os")
set(LINKER_FLAGS "${LINKER_FLAGS} -nostartfiles -lc -lnosys --specs=rdimon.specs -Wl,--gc-sections,-Map,${CMAKE_PROJECT_NAME}_${CMAKE_BUILD_TYPE}.map")

# Collect sources and includes
find_file(RTLIB_SRC "src" PATHS "${CMAKE_CURRENT_SOURCE_DIR}/RTLib" "${CMAKE_CURRENT_SOURCE_DIR}")
if (RTLIB_SRC STREQUAL "RTLIB_SRC-NOTFOUND")
    message(FATAL_ERROR "Could not find RTLib sources")
endif ()

file(GLOB_RECURSE RTLIB_SOURCE_FILES "${RTLIB_SRC}/*.c" "${RTLIB_SRC}/*.cpp")
include_directories(${RTLIB_SRC})
