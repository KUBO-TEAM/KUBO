import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/blocs/tomorrow_schedule/tomorrow_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_info_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/event_card.dart';

class TomorrowSchedule extends StatefulWidget {
  const TomorrowSchedule({
    Key? key,
  }) : super(key: key);

  @override
  State<TomorrowSchedule> createState() => _TomorrowScheduleState();
}

class _TomorrowScheduleState extends State<TomorrowSchedule> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<TomorrowScheduleBloc>(context)
        .add(TomorrowScheduleFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TomorrowScheduleBloc, TomorrowScheduleState>(
      builder: (context, state) {
        if (state is TomorrowScheduleSuccess) {
          final recipeSchedule = state.recipeSchedule;
          return InkWell(
            onTap: () {
              if (recipeSchedule != null) {
                Navigator.pushNamed(
                  context,
                  RecipeInfoPage.id,
                  arguments: RecipeInfoPageArguments(
                    recipe: recipeSchedule.recipe,
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tomorrow',
                        style: TextStyle(
                          color: kBlackPrimary,
                          fontFamily: 'Montserrat Bold',
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMMd('en_US').format(
                          DateTime.now().add(
                            const Duration(
                              days: 1,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: kBlackPrimary,
                          fontFamily: 'Montserrat',
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  EventCard(
                    eventTitle: 'Pending schedule',
                    eventIcon: Icons.pending_actions,
                    recipeSchedule: recipeSchedule,
                  )
                ],
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
