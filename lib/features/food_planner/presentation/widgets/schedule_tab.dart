import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/snackbar_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/create_recipe_schedule_dialog.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  Future<void> _showCreateScheduleDialog() async {
    await showDialog(
      context: context,
      builder: (_) {
        return CreateRecipeScheduleDialog(
          recipe: widget.recipe,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecipeInfoCreateRecipeScheduleBloc,
        RecipeInfoCreateRecipeScheduleState>(
      listener: (context, state) {
        if (state is RecipeInfoCreateRecipeScheduleSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(kSuccessfullySaveSnackBar);
        }
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
        ),
        child: SingleChildScrollView(
          child: BlocBuilder<RecipeInfoFetchRecipeSchedulesBloc,
              RecipeInfoFetchRecipeSchedulesState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoundedButton(
                    onPressed: () {
                      _showCreateScheduleDialog();
                    },
                    title: const Text('New schedule for this recipe'),
                    icon: const Icon(
                      Icons.schedule,
                      color: Colors.white,
                    ),
                  ),
                  const StartingTimeline(),
                  const MiddleTimeline(),
                  const EndingTimeline()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class EndingTimeline extends StatelessWidget {
  const EndingTimeline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isLast: true,
      indicatorStyle: IndicatorStyle(
        width: 30,
        color: kBrownPrimary,
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 7.5,
        ),
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: Icons.hourglass_full,
        ),
      ),
      beforeLineStyle: const LineStyle(color: kBlackPrimary),
      endChild: Container(
        padding: const EdgeInsets.only(
          left: 7.5,
          right: 7.5,
          top: 20.0,
        ),
        constraints: const BoxConstraints(
          minHeight: 100,
        ),
        // alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                child: const Text(
                  'Monday, June 15, 2022',
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Expanded(
              child: Text(
                '10:00 PM - 12:00 PM',
                style: TextStyle(fontSize: 13.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiddleTimeline extends StatelessWidget {
  const MiddleTimeline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      indicatorStyle: IndicatorStyle(
        width: 30,
        color: kBrownPrimary,
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 7.5,
        ),
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: Icons.hourglass_full,
        ),
      ),
      beforeLineStyle: const LineStyle(color: kBlackPrimary),
      afterLineStyle: const LineStyle(color: kBlackPrimary),
      endChild: Container(
        padding: const EdgeInsets.only(
          left: 7.5,
          right: 7.5,
          top: 20.0,
        ),
        constraints: const BoxConstraints(
          minHeight: 100,
        ),
        // alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                child: const Text(
                  'Monday, June 15, 2022',
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Expanded(
              child: Text(
                '10:00 PM - 12:00 PM',
                style: TextStyle(fontSize: 13.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StartingTimeline extends StatelessWidget {
  const StartingTimeline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: true,
      afterLineStyle: const LineStyle(color: kBlackPrimary),
      indicatorStyle: IndicatorStyle(
        width: 45,
        color: kGreenPrimary,
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
        ),
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: Icons.flag,
        ),
      ),
      endChild: Container(
        padding: const EdgeInsets.only(
          left: 7.5,
          right: 7.5,
          top: 25.0,
        ),
        constraints: const BoxConstraints(
          minHeight: 100,
        ),
        // alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                child: const Text(
                  'Monday, June 15, 2022',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Expanded(
              child: Text(
                '10:00 PM - 12:00 PM',
                style: TextStyle(fontSize: 13.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
