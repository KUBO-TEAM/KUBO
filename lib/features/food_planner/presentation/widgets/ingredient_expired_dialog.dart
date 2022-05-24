import 'package:flutter/material.dart';

class IngredientExpiredDialog extends StatelessWidget {
  const IngredientExpiredDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete expired ingredients?'),
      content: const Text(
        'Vegetables only takes 2 for 4 days before become rotten, Do you want to delete the expired ingredients?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
