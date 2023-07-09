import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'flutter_llama_bindings_generated.dart';

const String _libName = 'flutter_llama';

final DynamicLibrary _dylib = () {
  final libdir = path.join(path.dirname(Platform.resolvedExecutable), 'lib');
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('$libdir/lib$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$libdir\\$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

final FlutterLlamaBindings llama = FlutterLlamaBindings(_dylib);
