import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/text_styles.constants.dart';
import 'package:kubo/modules/meal_plan/models/ingredients.dart';

class CreateMealPlanScreen extends StatelessWidget {
  static const String id = 'create_meal_plan_screen';

  const CreateMealPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: kBlackPrimary, //change your color here
        ),
        elevation: 0,
        title: const Text(
          'Create Meal Plan',
          style: TextStyle(
            color: kBlackPrimary,
            fontFamily: 'Pushster',
            fontSize: 30.0,
          ),
        ),
      ),
      body: const SafeArea(
        child: IngredientsList(),
      ),
    );
  }
}

class IngredientsList extends StatefulWidget {
  const IngredientsList({Key? key}) : super(key: key);

  @override
  State<IngredientsList> createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
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
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Ingredients ingredient) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                ingredient.id,
                style: kPreSubTitleTextStyle,
              ), //TODO: Temporary ingredients id...
            );
          },
          body: Column(
            children: List.generate(ingredient.ingredients.length, (int index) {
              return ListTile(
                leading: const Icon(Icons.loyalty),
                title: Text(
                  ingredient.ingredients[index],
                  style: kCaptionTextStyle,
                ),
              );
            }),
          ),
          isExpanded: ingredient.isExpanded,
        );
      }).toList(),
    );
  }
}
