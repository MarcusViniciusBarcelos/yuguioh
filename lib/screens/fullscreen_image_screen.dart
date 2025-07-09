import 'package:flutter/material.dart';

class FullscreenImageScreen extends StatelessWidget {
  final String imageUrl;
  final Object heroTag;

  const FullscreenImageScreen({
    super.key,
    required this.imageUrl,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: heroTag,
            child: InteractiveViewer(
              minScale: 0.8,
              maxScale: 4,
              child: Image.network(imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}
