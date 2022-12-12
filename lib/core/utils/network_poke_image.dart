import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/core/res/images.dart';

class NetworkPokeImage extends StatelessWidget {
  const NetworkPokeImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });

  final String imageUrl;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Center(
        child: PokeImage.logo.toImage(),
      ),
    );
  }
}
