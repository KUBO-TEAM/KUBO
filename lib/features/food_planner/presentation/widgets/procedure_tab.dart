import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/ingredient.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_info_servings.dart';

class ProcedureTab extends StatefulWidget {
  const ProcedureTab({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  State<ProcedureTab> createState() => _ProcedureTabState();
}

class _ProcedureTabState extends State<ProcedureTab>
    with AutomaticKeepAliveClientMixin<ProcedureTab> {
  List<Ingredient> selectedIngredients = [];

  int servingsCounter = 1;

  bool isIngredientSelected(Ingredient ingredient) {
    if (selectedIngredients.isNotEmpty) {
      var foundIngredients =
          selectedIngredients.where((element) => element == ingredient);

      return foundIngredients.isNotEmpty ? true : false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ingredients: ',
                style: TextStyle(
                  color: kBlackPrimary,
                  fontSize: 20.0,
                  fontFamily: 'Montserrat Bold',
                ),
              ),
              RecipeInfoServings(
                icon: Icons.group,
                title: 'people',
                servings: widget.recipe.servings,
                color: kBlackPrimary,
                onChange: (value) {
                  setState(() {
                    servingsCounter = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          DataTable(
            showCheckboxColumn: true,
            columns: const [
              DataColumn(
                label: Text(
                  'Quantity',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: kBlackPrimary,
                    fontFamily: 'Montserrat Bold',
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Ingredient',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: kBlackPrimary,
                    fontFamily: 'Montserrat Bold',
                  ),
                ),
              ),
            ],
            rows: [
              for (Ingredient ingredient in widget.recipe.ingredients)
                DataRow(
                  selected: isIngredientSelected(ingredient),
                  cells: [
                    DataCell(
                      Center(
                        child: Text(
                          (ingredient.quantity * servingsCounter).toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: kBlackPrimary,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        ingredient.name,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: kBlackPrimary,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                  onSelectChanged: (bool? value) {
                    if (value == true) {
                      setState(() {
                        selectedIngredients.add(ingredient);
                      });
                    } else {
                      setState(() {
                        selectedIngredients.remove(ingredient);
                      });
                    }
                  },
                ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Instructions: ',
            style: TextStyle(
              fontSize: 20.0,
              color: kBlackPrimary,
              fontFamily: 'Montserrat Bold',
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) => RichText(
              text: TextSpan(
                text: '${(index + 1).toString()}. ',
                style: const TextStyle(
                  fontSize: 16,
                  color: kBlackPrimary,
                  fontFamily: 'Montserrat Bold',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.recipe.instructions[index],
                    style: const TextStyle(
                      fontSize: 16,
                      color: kBlackPrimary,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 8.0,
            ),
            itemCount: widget.recipe.instructions.length,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
