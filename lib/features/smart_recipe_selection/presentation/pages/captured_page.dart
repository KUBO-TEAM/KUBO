import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/scanned_pictures/scanned_pictures_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/camera_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/scanned_pictures_list_page.dart';

class CapturedPageArguments {
  final String imagePath;

  CapturedPageArguments({required this.imagePath});
}

class CapturedPage extends StatefulWidget {
  static const String id = 'captured_page';
  const CapturedPage({Key? key, required this.arguments}) : super(key: key);

  final CapturedPageArguments arguments;

  @override
  State<CapturedPage> createState() => _CapturedPageState();
}

class _CapturedPageState extends State<CapturedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Image.file(
          File(widget.arguments.imagePath),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        Positioned(
          right: 0,
          top: MediaQuery.of(context).viewPadding.top,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, CameraPage.id);
            },
            child: const Icon(Icons.close, color: Colors.white),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(2.0),
              primary: kBrownPrimary,
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: RoundedButton(
              icon: const Icon(Icons.save),
              title: const Text(
                'Save as scanned ingredients',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              onPressed: () {
                BlocProvider.of<ScannedPicturesBloc>(context).add(
                  ScannedPicturesSaved(imagePath: widget.arguments.imagePath),
                );
                Navigator.pushReplacementNamed(
                  context,
                  ScannedPicturesListPage.id,
                  arguments: ScannedPicturesListPageArguments(
                    imagePath: widget.arguments.imagePath,
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}
