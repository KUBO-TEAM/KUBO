import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/widgets/menu_history_event_tile.dart';

class MenuHistoryEventsList extends StatelessWidget {
  const MenuHistoryEventsList({
    Key? key,
    required ValueNotifier<List<RecipeSchedule>> selectedEvents,
    DateTime? selectedDay,
  })  : _selectedEvents = selectedEvents,
        _selectedDay = selectedDay,
        super(key: key);

  final ValueNotifier<List<RecipeSchedule>> _selectedEvents;
  final DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ValueListenableBuilder<List<RecipeSchedule>>(
          valueListenable: _selectedEvents,
          builder: (context, value, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 28.0,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                            color: Colors.grey.shade400,
                          ),
                          padding: const EdgeInsets.only(left: 25, right: 15),
                          child: const Center(
                            child: Text(
                              'Your event',
                              style: TextStyle(
                                fontFamily: 'Arvo',
                                color: kBlackPrimary,
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: kGreenPrimary,
                          radius: 14,
                          child: Text(
                            value.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.insert_invitation,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          formatDateTimeYYMMD(_selectedDay),
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 70,
                          child: MenuHistoryListTile(
                            recipeSchedule: value[index],
                            isLast: index == value.length - 1,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String formatDateTimeYYMMD(DateTime? date) {
    if (date != null) {
      return DateFormat.yMd().format(date);
    }

    return '';
  }
}
