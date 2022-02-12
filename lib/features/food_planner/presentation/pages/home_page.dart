import 'package:flutter/material.dart';
import 'package:kubo/features/food_planner/presentation/widgets/daily_plan.dart';
import 'package:kubo/features/food_planner/presentation/widgets/event_plan.dart';
import 'package:kubo/features/food_planner/presentation/widgets/floating_buttons.dart';
import 'package:kubo/features/food_planner/presentation/widgets/kubo_app_bars.dart';
import 'package:kubo/features/food_planner/presentation/widgets/planner_buttons.dart';
import 'package:kubo/features/food_planner/presentation/widgets/weekly_report.dart';

class HomePage extends StatelessWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      floatingActionButton: const FloatingHomeButton(),
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
            WeeklyReport(),
            SizedBox(
              height: 10.0,
            ),
            EventPlan(
              title: 'Today',
              date: 'December 28, 2021',
            ),
            SizedBox(
              height: 10.0,
            ),
            EventPlan(
              title: 'Tomorrow',
              date: 'December 29, 2021',
            ),
            DailyPlan(),
          ],
        ),
      ),
    );
  }
}
