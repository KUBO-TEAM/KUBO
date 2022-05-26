import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/predicted_image_view_page.dart';

class ScannedPicturesListTile extends StatefulWidget {
  const ScannedPicturesListTile({
    Key? key,
    required this.predictedImage,
    required this.onChange,
  }) : super(key: key);

  final PredictedImage predictedImage;
  final ValueChanged<PredictedImage> onChange;

  @override
  State<ScannedPicturesListTile> createState() =>
      _ScannedPicturesListTileState();
}

class _ScannedPicturesListTileState extends State<ScannedPicturesListTile> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          PredictedImageViewPage.id,
          arguments: PredictedImageViewPageArguments(
            predictedImage: widget.predictedImage,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(3),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.file(
                File(widget.predictedImage.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            if (_isSelected)
              Positioned.fill(
                child: Container(
                  color: const Color.fromARGB(52, 0, 94, 255),
                ),
              ),
            if (Utils.isPredictedImageExpired(
              widget.predictedImage.predictedAt,
            ))
              Positioned.fill(
                child: Container(
                  color: const Color.fromARGB(52, 255, 0, 0),
                ),
              ),
            Positioned(
              top: 5,
              right: 5,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isSelected = !_isSelected;
                    widget.onChange(widget.predictedImage);
                  });
                },
                child: CircleAvatar(
                  radius: 8.5,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: _isSelected
                        ? const Color.fromARGB(255, 0, 94, 255)
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
