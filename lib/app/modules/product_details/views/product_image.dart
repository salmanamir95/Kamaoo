import 'dart:convert';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BoxFit fit;

  const ProductImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    if (image == null || image!.isEmpty) {
      return Image.asset('assets/images/no_data.png',
          height: height, width: width, fit: fit);
    }
    try {
      final imageBytes = base64Decode(image!);
      return Image.memory(imageBytes, height: height, width: width, fit: fit);
    } catch (e) {
      return Image.asset('assets/images/no_data.png',
          height: height, width: width, fit: fit);
    }
  }
}
