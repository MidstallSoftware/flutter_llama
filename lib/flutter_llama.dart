import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'package:path/path.dart' as path;
import 'package:ffi/ffi.dart';

import 'flutter_llama_bindings_generated.dart' as bindings;

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

final _llama = bindings.FlutterLlamaBindings(_dylib);

class LlamaContext {
  const LlamaContext(this._value);

  final Pointer<bindings.context> _value;

  void dispose() {
    _llama.free(_value);
  }

  static Future<LlamaContext> fromFile(String path) async {
    final ptr = await Isolate.run(() {
      _llama.backend_init(true);
      final value = _llama.load_model_from_file(path.toNativeUtf8().cast(), _llama.context_default_params());
      if (value == nullptr) {
        throw Exception('Failed to initialize model');
      }
      return value.address;
    });
    return LlamaContext(Pointer.fromAddress(ptr));
  }
}
