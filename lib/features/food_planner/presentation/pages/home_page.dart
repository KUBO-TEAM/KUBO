import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/string_constants.dart';
import 'package:kubo/core/helpers/notification_reminder.dart';
import 'package:kubo/features/food_planner/presentation/blocs/user/user_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipes_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/bottom_navigation.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_updates.dart';
import 'package:kubo/features/food_planner/presentation/widgets/today_schedule.dart';
import 'package:kubo/features/food_planner/presentation/widgets/tomorrow_schedule.dart';
import 'package:kubo/features/food_planner/presentation/widgets/your_status.dart';
import 'package:kubo/features/food_planner/presentation/widgets/kubo_app_bars.dart';
import 'package:kubo/features/food_planner/presentation/widgets/message_dialog.dart';
import 'package:kubo/features/food_planner/presentation/widgets/planner_buttons.dart';
import 'package:kubo/features/food_planner/presentation/widgets/trained_veggies.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/camera_page.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    NotificationReminder.init(initScheduled: true);
    listenNotifications();

    BlocProvider.of<UserBloc>(context).add(UserFetched());
  }

  void listenNotifications() =>
      NotificationReminder.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.pushNamed(
        context,
        RecipesPage.id,
        arguments: RecipesPageArguments(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await Permission.camera.request().isGranted &&
              await Permission.storage.request().isGranted) {
            Navigator.pushNamed(context, CameraPage.id);
          } else {
            showDialog(
              context: context,
              builder: (_) => const MessageDialog(
                title: 'Permission is required!',
                message: kPermissionDenniedDialogMessage,
              ),
            );
          }
        },
        backgroundColor: kGreenPrimary,
        child: const Icon(
          Icons.camera,
          color: Colors.white,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavigation(),
      appBar: const KuboHomeAppBar('Overview'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 40.0,
          ),
          children: const [
            PlannerButtons(),
            SizedBox(
              height: 5.0,
            ),
            TrainedVeggies(),
            RecipeUpdates(),
            SizedBox(
              height: 16.0,
            ),
            YourStatus(),
            SizedBox(
              height: 16.0,
            ),
            TodaySchedule(),
            SizedBox(
              height: 16.0,
            ),
            TomorrowSchedule(),
          ],
        ),
      ),
    );
  }
}
