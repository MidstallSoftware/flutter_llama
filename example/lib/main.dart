import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_llama/flutter_llama.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:network_file_cached/network_file_cached.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xdg_directories/xdg_directories.dart' as xdg;

void main() async {
  switch (defaultTargetPlatform) {
    case TargetPlatform.linux:
      final dir = Directory('${xdg.cacheHome.path}/com.expidusos.flutter_llama_example');
      if (!dir.existsSync()) await dir.create(recursive: true);
      await Hive.initFlutter(dir.path);
      break;
    default:
      await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
      break;
  }

  await NetworkFileCached.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LlamaContext? _llama;
  String _modelProgressLabel = 'Downloading AI model';
  double? _modelProgress;

  @override
  void initState() {
    super.initState();

    NetworkFileCached.downloadFile(
      'https://huggingface.co/TheBloke/Selfee-13B-GGML/resolve/main/selfee-13b.ggmlv3.q2_K.bin',
      onReceiveProgress: (rcv, total) => setState(() {
        _modelProgress = rcv / total;
      })
    ).then((file) {
      setState(() {
        _modelProgressLabel = 'Initializing AI';
        _modelProgress = null;
        LlamaContext.fromFile(file.path).then((value) => setState(() {
          _llama = value;
        }));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    if (_llama != null) _llama!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_llama example'),
        ),
        body: Center(
          child: _llama == null
            ? Column(
                children: [
                  Text(_modelProgressLabel),
                  CircularProgressIndicator(value: _modelProgress)
                ],
              )
           : Container(),
        ),
      ),
    );
  }
}
