import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    Key? key,
    required this.message,
    required this.assetImageUrl,
    this.imageSize,
  }) : super(key: key);

  final String message;
  final String assetImageUrl;
  final double? imageSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          assetImageUrl,
          width: imageSize,
        ),
        Text(
          message,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 20,
            fontFamily: 'Montserrat Bold',
          ),
        ),
      ],
    );
  }
}
