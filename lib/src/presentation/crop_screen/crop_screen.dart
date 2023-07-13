import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../preview_screen/preview_screen.dart';

class CropScreen extends StatefulWidget {
  final String image;
  const CropScreen({super.key, required this.image});

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  var controller = CropController();

  Uint8List? uint8list;
  var cropping = ValueNotifier<bool>(false);

  loadImage() async {
    uint8list =
        (await NetworkAssetBundle(Uri.parse(widget.image)).load(widget.image))
            .buffer
            .asUint8List();

    setState(() {});
  }

  @override
  void initState() {
    loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cropping.value = true;
          controller.crop();
        },
        child: const Icon(Icons.crop),
      ),
      body: (uint8list == null)
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: cropping,
                  builder: (context, value, child) {
                    if (value) {
                      return const LinearProgressIndicator();
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                Expanded(
                  child: Crop(
                    controller: controller,
                    progressIndicator: const CircularProgressIndicator(),
                    image: uint8list!,
                    onCropped: (cropped) {
                      Get.off(PreviewScreen(
                        uint8list: cropped,
                      ));
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
