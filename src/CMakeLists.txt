# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(flutter_llama_library VERSION 0.0.1 LANGUAGES C)

add_library(flutter_llama SHARED
  "flutter_llama.c"
)

set_target_properties(flutter_llama PROPERTIES
  PUBLIC_HEADER flutter_llama.h
  OUTPUT_NAME "flutter_llama"
)

target_compile_definitions(flutter_llama PUBLIC DART_SHARED_LIB)
