import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_llama/flutter_llama.dart';
import 'package:file_picker/file_picker.dart';

void main() {
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
  File? _file;

  void _load() {
    setState(() {
      _modelProgressLabel = 'Initializing AI';
      _modelProgress = null;
      LlamaContext.fromFile(_file!.path).then((value) => setState(() {
        _llama = value;
      }));
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
          child: Column(
            children: [
              ...(_llama == null ? [
                Text(_modelProgressLabel),
                CircularProgressIndicator(value: _modelProgress)
              ] : []),
              ...(_file == null ? [
                TextButton(
                  onPressed: () =>
                    FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['gguf'],
                    ).then((result) {
                      if (result != null) {
                        _file = File(result!.files.single.path!);
                        _load();
                      }
                    }),
                  child: const Text('Select model')
                ),
              ] : [
                Text('Using model ${_file!.path}'),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
