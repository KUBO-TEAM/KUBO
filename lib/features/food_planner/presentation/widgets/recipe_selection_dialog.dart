import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_selection_dialog/recipe_selection_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/empty_state.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';

class RecipeSelectionDialog extends StatefulWidget {
  const RecipeSelectionDialog({
    Key? key,
    required this.actionButton,
  }) : super(key: key);

  final Widget Function(List<Category>) actionButton;

  @override
  State<RecipeSelectionDialog> createState() => _RecipeSelectionDialogState();
}

class _RecipeSelectionDialogState extends State<RecipeSelectionDialog> {
  List<Category> selectedCategories = [];

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
                child: BlocConsumer<RecipeSelectionDialogBloc,
                    RecipeSelectionDialogState>(
                  listener: (context, state) {
                    if (state is RecipeSelectionDialogSuccess) {
                      setState(() {
                        selectedCategories = List.from(state.categories);
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is RecipeSelectionDialogSuccess) {
                      if (state.categories.isEmpty) {
                        return const EmptyState(
                          message: 'No vegetables found',
                          assetImageUrl: "assets/images/empty_2.png",
                          imageSize: 200,
                        );
                      }
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
                                    selectedCategories.add(category);
                                  });
                                } else {
                                  setState(() {
                                    selectedCategories.remove(category);
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
            widget.actionButton(selectedCategories),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  bool isCategorySelected(Category category) {
    if (selectedCategories.isNotEmpty) {
      var foundCategories =
          selectedCategories.where((element) => element == category);

      return foundCategories.isNotEmpty ? true : false;
    }

    return false;
  }
}
