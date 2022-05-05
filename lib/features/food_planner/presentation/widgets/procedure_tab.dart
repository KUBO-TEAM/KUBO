import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/ingredient.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_info_icon_with_text.dart';

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
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ingredients: ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RecipeInfoIconWithText(
                  icon: Icons.group,
                  title: 'people',
                  data: widget.recipe.servings.toString(),
                  color: kBlackPrimary,
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
                  style: TextStyle(fontSize: 16.0),
                )),
                DataColumn(
                  label: Text(
                    'Ingredient',
                    style: TextStyle(fontSize: 16.0),
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
                            ingredient.quantity.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          ingredient.name,
                          style: const TextStyle(
                            fontSize: 16.0,
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
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) => RichText(
                text: TextSpan(
                  text: '${(index + 1).toString()}. ',
                  style: TextStyle(
                    color: DefaultTextStyle.of(context).style.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.recipe.instructions[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
