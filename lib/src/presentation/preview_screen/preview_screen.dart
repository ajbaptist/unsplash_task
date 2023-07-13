import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key, required this.uint8list});

  final Uint8List uint8list;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await ImageGallerySaver.saveImage(widget.uint8list);
          Fluttertoast.showToast(msg: result.toString());
        },
        child: const Icon(Icons.save),
      ),
      body: Center(child: Image.memory(widget.uint8list)),
    );
  }
}
