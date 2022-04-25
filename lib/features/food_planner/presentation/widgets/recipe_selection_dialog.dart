import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/examples/ingredients.examples.dart';
import 'package:kubo/features/food_planner/domain/entities/ingredient.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe/recipe_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipes_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';

class RecipeSelectionDialog extends StatefulWidget {
  const RecipeSelectionDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<RecipeSelectionDialog> createState() => _RecipeSelectionDialogState();
}

class _RecipeSelectionDialogState extends State<RecipeSelectionDialog> {
  List<Ingredient> selectedIngredient = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                padding: const EdgeInsets.only(top: 8, right: 8),
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Ingredient')),
                  ],
                  rows: [
                    for (Ingredient ingredient in kIngredientsExample)
                      DataRow(
                        selected: isIngredientSelected(ingredient),
                        cells: [
                          DataCell(Text(ingredient.quantity.toString())),
                          DataCell(Text(ingredient.name)),
                        ],
                        onSelectChanged: (bool? value) {
                          if (value == true) {
                            setState(() {
                              selectedIngredient.add(ingredient);
                            });
                          } else {
                            setState(() {
                              selectedIngredient.remove(ingredient);
                            });
                          }
                        },
                      ),
                  ],
                  showCheckboxColumn: true,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                RoundedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RecipesPage.id,
                      arguments: RecipesPageArguments(
                        ingredients: selectedIngredient,
                      ),
                    );
                  },
                  title: const Text('Proceed to recipe selection'),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  bool isIngredientSelected(Ingredient ingredient) {
    if (selectedIngredient.isNotEmpty) {
      var foundIngredients =
          selectedIngredient.where((element) => element == ingredient);

      return foundIngredients.isNotEmpty ? true : false;
    }

    return false;
  }
}
