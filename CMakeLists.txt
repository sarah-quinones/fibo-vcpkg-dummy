cmake_minimum_required(VERSION 3.15)

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake
  CACHE STRING "Vcpkg toolchain file")

project(fibo CXX)

find_package(fmt REQUIRED)
find_package(range-v3 REQUIRED)
find_package(cxxopts REQUIRED)

add_library(fibo src/main.cpp)
add_library(fibo::fibo ALIAS fibo)

# target_include_directories(fibo PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_include_directories(fibo PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/>
    $<INSTALL_INTERFACE:include/>  # <prefix>/include/mylib
)
target_compile_features(fibo PRIVATE cxx_std_17)

target_link_libraries(fibo
  PRIVATE
    fmt::fmt
    range-v3::range-v3
    cxxopts::cxxopts)

install(TARGETS fibo EXPORT fiboConfig)
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/fibo DESTINATION include)

install(EXPORT fiboConfig
        NAMESPACE fibo::
        DESTINATION lib/cmake/fibo)

export(EXPORT fiboConfig NAMESPACE fibo::)
