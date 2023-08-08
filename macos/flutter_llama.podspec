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
  s.framework = 'Accelerate'
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '10.13'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
