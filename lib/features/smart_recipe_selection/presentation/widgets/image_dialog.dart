import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';

class ImageDialog extends StatelessWidget {
  final File imageFile;

  const ImageDialog({Key? key, required this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kBrownPrimary,
      child: Stack(
        children: [
          Image.file(
            imageFile,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          ClipRRect(
            // Clip it cleanly.
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.2),
                alignment: Alignment.center,
              ),
            ),
          ),
          Image.file(
            imageFile,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
