import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';

class ShowAvailableIngredientsDialog extends StatelessWidget {
  ShowAvailableIngredientsDialog({Key? key}) : super(key: key);

  final List<String> categoriesAvailable = [
    'ampalaya',
    'carrot',
    'kamatis',
    'kangkong',
    'okra',
    'repolyo',
    'sayote',
    'sitaw',
    'talong',
    'upo',
  ];

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
                        '10 Available Vegetables to Scan',
                        style: TextStyle(
                          color: kBlackPrimary,
                          fontFamily: 'Montserrat Bold',
                        ),
                      ),
                    ),
                  ],
                  rows: [
                    for (String category in categoriesAvailable)
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              category,
                              style: const TextStyle(
                                color: kBlackPrimary,
                                fontFamily: 'Montserrat ',
                                fontSize: 14.0,
                              ),
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
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
