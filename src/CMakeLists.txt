cmake_minimum_required(VERSION 3.10)

project(flutter_llama_library VERSION 0.0.1 LANGUAGES C)

set(BUILD_SHARED_LIBS ON)
add_subdirectory(llama.cpp)
add_library(flutter_llama ALIAS llama)
set_target_properties(llama PROPERTIES OUTPUT_NAME flutter_llama)
install(TARGETS llama
  DESTINATION "lib")
