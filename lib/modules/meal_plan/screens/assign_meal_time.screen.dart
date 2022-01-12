import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/list.costants.dart';
import 'package:kubo/constants/text_styles.constants.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';
import 'package:kubo/widgets/buttons/square.button.dart';
import 'package:kubo/widgets/cards/picker.card.dart';
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

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as AssignMealTimeScreenArguments;

    final Recipe recipe = args.recipe;

    Size size = MediaQuery.of(context).size;

    AppBar appBar = AppBar(
      backgroundColor: Colors.transparent,
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
    );

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: appBar,
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
                      leadingIcon: Icons.calendar_today,
                      onSelected: (String? daySelected) {
                        day = daySelected;
                      },
                    ),
                    TimeSelector(
                      title: 'Start',
                      onTimePicked: (TimeOfDay? startTimePicked) {
                        start = startTimePicked;
                      },
                    ),
                    TimeSelector(
                      title: 'End',
                      onTimePicked: (TimeOfDay? endTimePicked) {
                        end = endTimePicked;
                      },
                    ),
                    SquareButton(
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: appBar.preferredSize.height + 20.0,
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
              top: appBar.preferredSize.height + 40.0,
              left: 16,
              child: SizedBox(
                width: size.width - 40,
                child: const Text(
                  'No schedule',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
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
}
