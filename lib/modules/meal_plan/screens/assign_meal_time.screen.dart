import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kubo/constants/list.costants.dart';
import 'package:kubo/constants/sizes.constants.dart';
import 'package:kubo/constants/string.constants.dart';
import 'package:kubo/constants/text_styles.constants.dart';
import 'package:kubo/core/models/schedule.hive.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';
import 'package:kubo/widgets/buttons/square.button.dart';
import 'package:kubo/widgets/clippers/recipe.clipper.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:kubo/widgets/selectors/direct.selector.dart';
import 'package:kubo/widgets/selectors/time.selector.dart';

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
  String? day = 'Monday';
  TimeOfDay? start;
  TimeOfDay? end;
  Box<dynamic>? scheduleBox;
  ScheduleHive? schedule;

  Future<void> initializeBox() async {
    scheduleBox = await Hive.openBox(kScheduleBox);
    if (scheduleBox != null) {
      final args = ModalRoute.of(context)!.settings.arguments
          as AssignMealTimeScreenArguments;

      final Recipe recipe = args.recipe;

      setState(() {
        schedule = scheduleBox!.get(recipe.id);
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
                    DirectSelector(
                      list: kDayList,
                      initialDay:
                          schedule != null ? schedule!.scheduledDay : null,
                      leadingIcon: Icons.calendar_today,
                      onSelected: (String? daySelected) {
                        day = daySelected;
                      },
                    ),
                    TimeSelector(
                      title: 'Start',
                      initialTime: _stringToTimeOfDay(schedule?.startingTime),
                      onTimePicked: (TimeOfDay? startTimePicked) {
                        start = startTimePicked;
                      },
                    ),
                    TimeSelector(
                      title: 'End',
                      initialTime: _stringToTimeOfDay(schedule?.endingTime),
                      onTimePicked: (TimeOfDay? endTimePicked) {
                        end = endTimePicked;
                      },
                    ),
                    SquareButton(
                      onPressed: () => onSave(recipe),
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

  Future<void> onSave(Recipe recipe) async {
    if (schedule == null) {
      if (day != null && start != null && end != null) {
        ScheduleHive newSchedule = ScheduleHive(
          recipeName: recipe.name,
          scheduledDay: day!,
          startingTime: start!.format(context),
          endingTime: end!.format(context),
        );

        scheduleBox!.put(recipe.id, newSchedule);

        setState(() {
          schedule = newSchedule;
        });
      }
    } else {
      schedule!.scheduledDay = day != null ? day! : schedule!.scheduledDay;
      schedule!.startingTime =
          start != null ? start!.format(context) : schedule!.startingTime;
      schedule!.endingTime =
          end != null ? end!.format(context) : schedule!.endingTime;

      schedule!.save();

      setState(() {});
    }
  }

  String _scheduleFormatter(ScheduleHive? scheduleHive) {
    return '${scheduleHive!.scheduledDay}, ${scheduleHive.startingTime} - ${scheduleHive.endingTime}';
  }

  TimeOfDay? _stringToTimeOfDay(String? time) {
    if (time == null) {
      return null;
    }
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh +
          int.parse(time.split(":")[0]) %
              24, // in case of a bad time format entered manually by the user
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }
}
