import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/list.costants.dart';
import 'package:kubo/constants/sizes.constants.dart';
import 'package:kubo/constants/snackbar.constants.dart';
import 'package:kubo/constants/string.constants.dart';
import 'package:kubo/constants/text_styles.constants.dart';
import 'package:kubo/core/models/schedule.hive.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';
import 'package:kubo/widgets/buttons/square.button.dart';
import 'package:kubo/widgets/clippers/recipe.clipper.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:kubo/widgets/selectors/color.selector.dart';
import 'package:kubo/widgets/selectors/day.selector.dart';
import 'package:kubo/widgets/selectors/time.selector.dart';
import 'package:flutter_beautiful_popup/main.dart';

class AssignMealTimeScreenArguments {
  AssignMealTimeScreenArguments({
    required this.recipe,
  });

  Recipe recipe;
}

class AssignMealTimeScreen extends StatefulWidget {
  static const String id = 'assign_meal_time_screen';

  const AssignMealTimeScreen({Key? key}) : super(key: key);

  @override
  State<AssignMealTimeScreen> createState() => _AssignMealTimeScreenState();
}

class _AssignMealTimeScreenState extends State<AssignMealTimeScreen> {
  int? day = 1;
  TimeOfDay? start;
  TimeOfDay? end;
  Box<dynamic>? scheduleBox;
  ScheduleHive? schedule;
  Color colorPicked = kGreenPrimary;

  Future<void> initializeBox() async {
    scheduleBox = await Hive.openBox(kScheduleBox);
    if (scheduleBox!.isEmpty == false) {
      final args = ModalRoute.of(context)!.settings.arguments
          as AssignMealTimeScreenArguments;

      final Recipe recipe = args.recipe;

      // scheduleBox!.deleteAll(scheduleBox!.keys);

      setState(() {
        schedule = scheduleBox!.get(recipe.id);

        if (schedule != null) {
          day =
              kDayList.indexOf(DateFormat('EEEE').format(schedule!.startTime));
          start = _dateTimeToTimeOfDay(schedule!.startTime);
          end = _dateTimeToTimeOfDay(schedule!.endTime);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializeBox();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as AssignMealTimeScreenArguments;

    final Recipe recipe = args.recipe;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: kAppBarPrefferedSize,
        child: AppBar(
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          title: const Text(
            'Assign Meal Time',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Pushster',
              fontSize: 30.0,
            ),
          ),
        ),
      ),
      body: DirectSelectContainer(
        child: Stack(
          children: [
            Positioned.fill(
              //
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xCC000000),
                    Color(0x00000000),
                    Color(0x00000000),
                    Color(0xCC000000),
                  ],
                ),
              ),
            ),
            const RecipeClipper(),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height / 2 + 50,
                width: size.width - 10,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pick a schedule',
                      style: kTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DaySelector(
                      list: kDayList,
                      initialDay: _directSelectInitialDay(schedule?.startTime),
                      leadingIcon: Icons.calendar_today,
                      onSelected: (int? daySelected) {
                        if (daySelected != null) {
                          setState(() => day = daySelected);
                        }
                      },
                    ),
                    TimeSelector(
                      title: 'Start',
                      initialTime: start,
                      onTimePicked: (TimeOfDay? startTimePicked) {
                        if (startTimePicked != null) {
                          setState(() {
                            start = startTimePicked;
                          });
                        }
                      },
                    ),
                    TimeSelector(
                      title: 'End',
                      initialTime: end,
                      onTimePicked: (TimeOfDay? endTimePicked) {
                        if (endTimePicked != null) {
                          setState(() {
                            end = endTimePicked;
                          });
                        }
                      },
                    ),
                    ColorSelector(
                      onColorPicked: (Color? selectedColor) {
                        colorPicked = selectedColor!;
                      },
                    ),
                    SquareButton(
                      onPressed: () => onSave(
                        recipe: recipe,
                        start: start,
                        end: end,
                        day: day,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 65.0,
              left: 16,
              child: SizedBox(
                width: size.width - 40,
                child: Text(
                  recipe.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 85.0,
              left: 16,
              child: SizedBox(
                width: size.width - 40,
                child: Text(
                  schedule != null
                      ? _scheduleFormatter(schedule)
                      : 'No schedule',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onSave(
      {Recipe? recipe, TimeOfDay? start, TimeOfDay? end, int? day}) async {
    if (recipe != null && start != null && end != null && day != null) {
      final popup = BeautifulPopup(
        context: context,
        template: TemplateTerm,
      );
      popup.show(
        title: 'Wait, Are you sure?',
        content:
            'You want to save ${recipe.name} to your ${start.format(context)} to ${end.format(context)} meal on $day ?',
        actions: [
          popup.button(
            label: 'Yes',
            onPressed: () {
              if (schedule == null) {
                final today = DateTime.now();

                final todayWeekday = DateFormat('EEEE').format(today);
                final indexTodayWeekDay = kDayList.indexOf(todayWeekday);
                final scheduleDay = today.day + (day - indexTodayWeekDay);

                ScheduleHive newSchedule = ScheduleHive(
                  recipeId: recipe.name,
                  recipeName: recipe.name,
                  startTime: DateTime(
                    today.year,
                    today.month,
                    scheduleDay,
                    start.hour,
                    start.minute,
                  ),
                  endTime: DateTime(
                    today.year,
                    today.month,
                    scheduleDay,
                    end.hour,
                    end.minute,
                  ),
                  color: colorPicked,
                );

                scheduleBox!.put(recipe.id, newSchedule);

                setState(() {
                  schedule = newSchedule;
                });
              } else {
                final today = DateTime.now();

                final todayWeekday = DateFormat('EEEE').format(today);
                final indexTodayWeekDay = kDayList.indexOf(todayWeekday);
                final scheduleDay = today.day + (day - indexTodayWeekDay);

                schedule!.startTime = DateTime(
                  today.year,
                  today.month,
                  scheduleDay,
                  start.hour,
                  start.minute,
                );

                schedule!.endTime = DateTime(
                  today.year,
                  today.month,
                  scheduleDay,
                  end.hour,
                  end.minute,
                );

                schedule!.save();

                setState(() {});
              }

              Navigator.of(context).pop();

              ScaffoldMessenger.of(context)
                  .showSnackBar(kSuccessfullySaveSnackBar);
            },
          ),
        ],
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(kFailedSaveSnackBar);
    }
  }

  String _scheduleFormatter(ScheduleHive? scheduleHive) {
    final todayWeekday = DateFormat('EEEE').format(scheduleHive!.startTime);

    return '$todayWeekday, ${_dateTimeToString(scheduleHive.startTime)} - ${_dateTimeToString(scheduleHive.endTime)}';
  }

  String? _dateTimeToString(DateTime? time) {
    if (time == null) {
      return null;
    }

    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(time);
  }

  TimeOfDay? _dateTimeToTimeOfDay(DateTime? time) {
    if (time == null) {
      return null;
    }

    return TimeOfDay(hour: time.hour, minute: time.minute);
  }

  int? _directSelectInitialDay(DateTime? startTime) {
    if (startTime != null) {
      final todayWeekday = DateFormat('EEEE').format(startTime);
      return kDayList.indexOf(todayWeekday);
    }

    return null;
  }
}
