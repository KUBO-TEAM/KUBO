import 'package:flutter/material.dart';

import 'colors_constants.dart';

var kSuccessfullySaveSnackBar = SnackBar(
  backgroundColor: kGreenPrimary,
  duration: const Duration(milliseconds: 1500),
  content: Row(
    children: const [
      Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
      SizedBox(
        width: 10.0,
      ),
      Text(
        'Successfully save new schedule!',
        style: TextStyle(color: Colors.white),
      ),
    ],
  ),
);

var kFailedSaveSnackBar = SnackBar(
  backgroundColor: Colors.red.shade700,
  content: Row(
    children: const [
      Icon(
        Icons.dangerous,
        color: Colors.white,
      ),
      SizedBox(
        width: 10.0,
      ),
      Text(
        'Opsie please pick, time and day first!',
        style: TextStyle(color: Colors.white),
      ),
    ],
  ),
);

var kUpdatingRecipeScheduleSnackBar = SnackBar(
  backgroundColor: kGreenPrimary,
  content: SizedBox(
    height: 30,
    child: Column(
      children: [
        Row(
          children: const [
            Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Successfully save new schedule!',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        const LinearProgressIndicator(),
      ],
    ),
  ),
);
