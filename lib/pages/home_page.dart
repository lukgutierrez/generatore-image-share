import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _keyBoundary = GlobalKey();

  Future<Uint8List> _generateImage() async {
    final currentContext = _keyBoundary.currentContext;
    final boundary =
        currentContext!.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary!.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    final directory = (await getExternalStorageDirectory());
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    File imgFile = new File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);

    return _generateImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: _keyBoundary,
              child: Carta(),
            ),
            ElevatedButton(
                onPressed: () {
                 
                  _generateImage();
                },
                child: Container(
                  child: Text("Generar Imagen"),
                ))
          ],
        ),
      ),
    );
  }
}

class Carta extends StatelessWidget {
  const Carta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.pink,
    );
  }
}
