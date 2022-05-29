import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/blocs/today_schedule/today_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/event_card.dart';

class TodaySchedule extends StatefulWidget {
  const TodaySchedule({
    Key? key,
  }) : super(key: key);

  @override
  State<TodaySchedule> createState() => _TodayScheduleState();
}

class _TodayScheduleState extends State<TodaySchedule> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<TodayScheduleBloc>(context).add(TodayScheduleFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayScheduleBloc, TodayScheduleState>(
      builder: (context, state) {
        if (state is TodayScheduleSuccess) {
          final recipeSchedule = state.recipeSchedule;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Today',
                      style: TextStyle(
                        color: kBlackPrimary,
                        fontFamily: 'Montserrat Bold',
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMd('en_US').format(DateTime.now()),
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
                  recipeSchedule: recipeSchedule,
                )
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}
