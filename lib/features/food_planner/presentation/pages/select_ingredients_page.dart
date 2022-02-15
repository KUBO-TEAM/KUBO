import 'package:flutter/material.dart';
import 'package:kubo/core/constants/text_styles_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/ingredients_box.dart';
import 'package:kubo/features/food_planner/presentation/widgets/kubo_app_bars.dart';
import 'package:kubo/features/food_planner/presentation/widgets/selected_ingredient_body.dart';

class SelectIngredientsPage extends StatefulWidget {
  static const String id = 'select_ingredients_page';

  const SelectIngredientsPage({Key? key}) : super(key: key);

  @override
  State<SelectIngredientsPage> createState() => _SelectIngredientsPageState();
}

class _SelectIngredientsPageState extends State<SelectIngredientsPage> {
  final List<IngredientsBox> _data = [
    IngredientsBox(
      id: 'Recent Ingredients',
      ingredients: const [
        'Repolyo',
        'Kangkong',
        'Sitaw',
      ],
      isExpanded: false,
    ),
    IngredientsBox(
      id: 'January 3, 2022',
      ingredients: const [
        'Talong',
      ],
      isExpanded: false,
    ),
    IngredientsBox(
      id: 'January 2, 2022',
      ingredients: const [
        'Carrots',
      ],
      isExpanded: false,
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
            children:
                _data.map<ExpansionPanel>((IngredientsBox ingredientsBox) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    leading: Icon(
                      Icons.shopping_basket,
                      color: Colors.amber.shade700,
                    ),
                    title: Text(
                      ingredientsBox.id,
                      style: kPreSubTitleTextStyle,
                    ),
                  );
                },
                body: SelectIngredientBody(
                  ingredientsBox: ingredientsBox,
                ),
                isExpanded: ingredientsBox.isExpanded,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
