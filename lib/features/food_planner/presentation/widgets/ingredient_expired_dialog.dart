import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/scanned_pictures_list/scanned_pictures_list_bloc.dart';

class IngredientExpiredDialog extends StatelessWidget {
  const IngredientExpiredDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete unfit vegatables?'),
      content: const Text(
        'Vegetables only takes 2-4 days before it becomes unfit for cooking. Do you want to delete pictures that match this description?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            BlocProvider.of<ScannedPicturesListBloc>(context).add(
              ScannedPicturesListExpiredPredictedImagesDeleted(),
            );

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
