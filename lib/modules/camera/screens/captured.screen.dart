import 'package:flutter/material.dart';
import 'dart:io';

class CapturedScreenArguments {
  final String imagePath;

  CapturedScreenArguments({required this.imagePath});
}

class CapturedScreen extends StatelessWidget {
  static const String id = 'captured_screen';
  const CapturedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CapturedScreenArguments;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.file(
              File(args.imagePath),
            ),
          ),
        ),
      ),
    );
  }
}
