import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:blog/core/constants/env.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum ImageType { network, local }

class SmartImage extends StatelessWidget {
  final BoxFit? fit;
  final double? radius;
  final ImageType type;
  final String? imageUrl;
  final String? file;

  const SmartImage(
      {super.key,
      this.fit,
      this.radius,
      required this.type,
      this.imageUrl,
      this.file});

  @override
  Widget build(BuildContext context) {
    if (type == ImageType.network) {
      return CachedNetworkImage(
        imageUrl: imageUrl ?? AppKey.PLACE_HOLDER_IMAGE,
        fit: fit,
      );
    }
    return Image.file(
      File(file!),
      fit: fit,
    );
  }

  Uint8List imageDecoder(String image) {
    final List<int> list = List<int>.from(jsonDecode(image));
    return Uint8List.fromList(list);
  }
}
