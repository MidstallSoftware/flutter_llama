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
  s.source = { :path => '../src/llama.cpp' }
  s.source_files = '{ggml.c,llama.cpp}'
  s.public_header_files = 'llama.h'
  s.framework = 'Accelerate'
  s.macos.deployment_target = '10.10'
end
