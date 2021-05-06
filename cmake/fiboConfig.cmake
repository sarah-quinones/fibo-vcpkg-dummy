include(CMakeFindDependencyMacro)
find_dependency(Foo)
include("${CMAKE_CURRENT_LIST_DIR}/fiboTargets.cmake")
