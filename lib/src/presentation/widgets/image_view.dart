import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../data/model/image_model.dart';
import '../crop_screen/crop_screen.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    super.key,
    required this.e,
  });

  final List<ImageModel> e;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      itemCount: e.length,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Hero(
              tag: e[index].id,
              child: GestureDetector(
                onTap: () {
                  Get.to(CropScreen(image: e[index].urls.regular));
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: Image.network(
                    e[index].urls.regular,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
