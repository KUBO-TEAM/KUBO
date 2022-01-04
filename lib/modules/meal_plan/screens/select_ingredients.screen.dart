import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/text_styles.constants.dart';
import 'package:kubo/modules/meal_plan/models/ingredients.dart';
import 'package:kubo/modules/meal_plan/screens/create_meal_plan.screen.dart';

class SelectIngredientsScreen extends StatelessWidget {
  static const String id = 'select_ingredients_screen';

  const SelectIngredientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: kBlackPrimary, //change your color here
        ),
        elevation: 0,
        title: const Text(
          'Ingredients List',
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
              leading: Icon(
                Icons.shopping_basket,
                color: Colors.amber.shade700,
              ),
              title: Text(
                ingredient.id,
                style: kPreSubTitleTextStyle,
              ), //TODO: Temporary ingredients id...
            );
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: List.generate(
                  ingredient.ingredients.length,
                  (int index) {
                    return ListTile(
                      leading: const Icon(
                        Icons.grade,
                        color: kGreenPrimary,
                      ),
                      title: Text(
                        ingredient.ingredients[index],
                        style: kPreSubTitleTextStyle.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 16.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Center(
                    child: Text(
                      'CREATE MEAL PLAN',
                      style: kCaptionTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, CreateMealPlanScreen.id);
                },
              ),
            ],
          ),
          isExpanded: ingredient.isExpanded,
        );
      }).toList(),
    );
  }
}
