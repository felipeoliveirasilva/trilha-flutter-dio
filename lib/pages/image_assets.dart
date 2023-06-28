import 'package:flutter/material.dart';
import 'package:trilhaflutterdio/shared/app_images.dart';

class ImageAssets extends StatefulWidget {
  const ImageAssets({super.key});

  @override
  State<ImageAssets> createState() => _ImageAssetsState();
}

class _ImageAssetsState extends State<ImageAssets> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          AppImages.user1,
          height: 200,
        ),
        Image.asset(
          AppImages.user1,
          height: 200,
        ),
        Image.asset(
          AppImages.user1,
          height: 200,
        ),
        Image.asset(
          AppImages.paisagem1,
          height: 200,
        ),
        Image.asset(
          AppImages.paisagem1,
          height: 200,
        ),
        Image.asset(
          AppImages.paisagem1,
          height: 200,
        )
      ],
    );
  }
}
