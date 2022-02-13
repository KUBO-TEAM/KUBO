import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/text_styles_constants.dart';
import 'package:kubo/core/temp/ingredients.dart';
import 'package:kubo/features/food_planner/presentation/widgets/kubo_app_bars.dart';
import 'package:kubo/features/food_planner/presentation/widgets/selected_ingredient_body.dart';

class SelectIngredientsPage extends StatefulWidget {
  static const String id = 'select_ingredients_page';

  const SelectIngredientsPage({Key? key}) : super(key: key);

  @override
  State<SelectIngredientsPage> createState() => _SelectIngredientsPageState();
}

class _SelectIngredientsPageState extends State<SelectIngredientsPage> {
  final List<Ingredients> _data = [
    Ingredients(
      id: 'Recent Ingredients',
      ingredients: [
        'Repolyo',
        'Kangkong',
        'Sitaw',
      ],
    ),
    Ingredients(
      id: 'January 3, 2022',
      ingredients: [
        'Talong',
      ],
    ),
    Ingredients(
      id: 'January 2, 2022',
      ingredients: [
        'Carrots',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const KuboAppBar('Ingredients List'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _data[index].isExpanded = !isExpanded;
              });
            },
            children: _data.map<ExpansionPanel>((Ingredients ingredient) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    leading: Icon(
                      Icons.shopping_basket,
                      color: Colors.amber.shade700,
                    ),
                    title: Text(
                      ingredient.id,
                      style: kPreSubTitleTextStyle,
                    ),
                  );
                },
                body: SelectIngredientBody(
                  ingredient: ingredient,
                ),
                isExpanded: ingredient.isExpanded,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
