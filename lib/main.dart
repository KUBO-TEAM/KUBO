import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/hive/adapters/color.adapter.dart';
import 'package:kubo/core/hive/objects/recipe_schedule_hive.dart';
import 'package:kubo/core/widgets/splash_page.dart';
import 'package:kubo/features/food_planner/presentation/blocs/assign_meal/assign_meal_plan_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_schedule/recipe_schedule_bloc.dart';
import 'package:kubo/injection.dart';
import 'package:kubo/router.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await path_provider.getApplicationDocumentsDirectory();

  Hive
    ..init(directory.path)
    ..registerAdapter(ColorAdapter())
    ..registerAdapter(RecipeScheduleHiveAdapter());

  await configureDependencies();

  runApp(
    getIt<Kubo>(),
  );
}

@lazySingleton
class Kubo extends StatelessWidget {
  const Kubo({
    required this.appRouter,
  }) : super(key: null);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<RecipeScheduleBloc>()),
        BlocProvider(create: (_) => AssignMealPlanBloc()),
      ],
      child: MaterialApp(
        initialRoute: SplashPage.id,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
