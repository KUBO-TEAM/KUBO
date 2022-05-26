import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_selection_dialog/recipe_selection_dialog_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<RecipeSelectionDialogBloc>(context).add(
      RecipeSelectionDialogCategoriesFetched(),
    );
  }

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
                child: BlocBuilder<RecipeSelectionDialogBloc,
                    RecipeSelectionDialogState>(
                  builder: (context, state) {
                    if (state is RecipeSelectionDialogSuccess) {
                      return DataTable(
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Accuracy',
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
                          for (Category category in state.categories)
                            DataRow(
                              selected: isCategorySelected(category),
                              cells: [
                                DataCell(
                                  Text(
                                    Utils.toPercentage(category.accuracy),
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
                      );
                    }

                    return Container();
                  },
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
