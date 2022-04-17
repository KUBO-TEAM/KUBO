import 'dart:io';

import 'package:flutter/material.dart';

class ScannedPicturesListTile extends StatefulWidget {
  const ScannedPicturesListTile({
    Key? key,
    required this.picture,
    required this.onChange,
  }) : super(key: key);

  final String picture;
  final ValueChanged<String> onChange;

  @override
  State<ScannedPicturesListTile> createState() =>
      _ScannedPicturesListTileState();
}

class _ScannedPicturesListTileState extends State<ScannedPicturesListTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(widget.picture),
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
                  widget.onChange(widget.picture);
                });
              },
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 4,
                  backgroundColor: isSelected
                      ? Colors.green
                      : const Color.fromARGB(255, 241, 241, 241),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
