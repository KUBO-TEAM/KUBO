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
        const SizedBox(
          height: 40,
        ),
        Image.asset(
          assetImageUrl,
          width: imageSize ?? 280,
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          message,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 18,
            fontFamily: 'Montserrat Bold',
          ),
        ),
      ],
    );
  }
}
