import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/smart_recipe_list_page.dart';

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
              Navigator.pop(context);
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
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: RoundedButton(
                icon: const Icon(Icons.arrow_back),
                title: const Text(
                  'Check recipes',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, SmartRecipeListPage.id);
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
