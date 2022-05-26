import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';

class DetectedCategoriesDialog extends StatelessWidget {
  const DetectedCategoriesDialog({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<Category> categories;

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
                    for (Category category in categories)
                      DataRow(
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
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      kBboxColorClass[category.name],
                                  radius: 6.0,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  category.name,
                                  style: const TextStyle(
                                    color: kBlackPrimary,
                                    fontFamily: 'Montserrat ',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                  showCheckboxColumn: true,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
