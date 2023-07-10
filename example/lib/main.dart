import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_llama/flutter_llama.dart';
import 'package:path/path.dart' as path;

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

  @override
  void initState() {
    super.initState();

    LlamaContext.fromFile('${path.dirname(Platform.resolvedExecutable)}/data/flutter_assets/assets/models/selfee-13b.ggmlv3.q2_K.bin').then((value) => setState(() {
      _llama = value;
    }));
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
          child: _llama == null ? const CircularProgressIndicator()
            : Container(),
        ),
      ),
    );
  }
}
