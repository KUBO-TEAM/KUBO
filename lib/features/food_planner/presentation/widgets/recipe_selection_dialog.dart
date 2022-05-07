import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/examples/ingredients.examples.dart';
import 'package:kubo/features/food_planner/domain/entities/category.dart';
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
  List<Category> selectedCategory = [];

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
                    DataColumn(
                      label: Text(
                        'Quantity',
                        style: TextStyle(
                          color: kBlackPrimary,
                          fontFamily: 'Montserrat Bold',
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Ingredient',
                        style: TextStyle(
                          color: kBlackPrimary,
                          fontFamily: 'Montserrat Bold',
                        ),
                      ),
                    ),
                  ],
                  rows: [
                    for (Category category in kCategoriesExample)
                      DataRow(
                        selected: isCategorySelected(category),
                        cells: [
                          DataCell(
                            Text(
                              category.quantity.toString(),
                              style: const TextStyle(
                                color: kBlackPrimary,
                                fontFamily: 'Montserrat ',
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              category.name,
                              style: const TextStyle(
                                color: kBlackPrimary,
                                fontFamily: 'Montserrat ',
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                        onSelectChanged: (bool? value) {
                          if (value == true) {
                            setState(() {
                              selectedCategory.add(category);
                            });
                          } else {
                            setState(() {
                              selectedCategory.remove(category);
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
                    Navigator.pushReplacementNamed(
                      context,
                      RecipesPage.id,
                      arguments: RecipesPageArguments(
                        categories: selectedCategory,
                      ),
                    );
                  },
                  title: const Text(
                    'Proceed to recipe selection',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat Medium',
                      fontSize: 14.0,
                    ),
                  ),
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

  bool isCategorySelected(Category category) {
    if (selectedCategory.isNotEmpty) {
      var foundCategories =
          selectedCategory.where((element) => element == category);

      return foundCategories.isNotEmpty ? true : false;
    }

    return false;
  }
}
