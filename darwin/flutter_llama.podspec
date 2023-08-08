Pod::Spec.new do |s|
  s.name = 'flutter_llama'
  s.version = '0.0.1'
  s.summary = 'llama.cpp bindings for Flutter'
  s.description = <<-DESC
llama.cpp bindings for Flutter
                  DESC
  s.homepage = 'https://github.com/ExpidusOS/flutter_llama'
  s.license = { :file => '../LICENSE' }
  s.author = { 'Midstall Software' => 'inquire@midstall.com' }
  s.source = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Headers/**/*'
  s.framework = 'Accelerate'
  s.ios.dependency 'Flutter'
  s.osx.dependency 'FlutterMacOS'
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.14'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
  s.library = 'c++'
  s.xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
    'CLANG_CXX_LIBRARY' => 'libc++'
  }
end
