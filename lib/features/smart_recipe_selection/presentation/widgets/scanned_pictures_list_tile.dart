import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/predicted_image_view_page.dart';

class ScannedPicturesListTile extends StatefulWidget {
  const ScannedPicturesListTile({
    Key? key,
    required this.predictedImage,
    required this.onChange,
  }) : super(key: key);

  final PredictedImage predictedImage;
  final ValueChanged<String> onChange;

  @override
  State<ScannedPicturesListTile> createState() =>
      _ScannedPicturesListTileState();
}

class _ScannedPicturesListTileState extends State<ScannedPicturesListTile> {
  bool isSelected = false;

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
        padding: const EdgeInsets.all(2),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.file(
                File(widget.predictedImage.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 3,
              right: 3,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                    widget.onChange(widget.predictedImage.imageUrl);
                  });
                },
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: isSelected
                        ? Colors.green
                        : const Color.fromARGB(
                            255,
                            241,
                            241,
                            241,
                          ),
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
