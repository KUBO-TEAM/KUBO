import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/hive/adapters/color.adapter.dart';
import 'package:kubo/core/hive/objects/schedule.hive.dart';
import 'package:kubo/core/temp/local_storage_service.dart';
import 'package:kubo/core/temp/menu_history_repositories.dart';
import 'package:kubo/core/temp/menu_repository.dart';
import 'package:kubo/core/walk_through/splash_page.dart';
import 'package:kubo/features/food_planner/presentation/blocs/agenda/agenda_cubit.dart';
import 'package:kubo/features/food_planner/presentation/blocs/assign_meal/meal_plan_cubit.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu/menu_cubit.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu_history/menu_history_cubit.dart';
import 'package:kubo/injection.dart';
import 'package:kubo/router.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await path_provider.getApplicationDocumentsDirectory();

  Hive
    ..init(directory.path)
    ..registerAdapter(ColorAdapter())
    ..registerAdapter(ScheduleHiveAdapter());

  configureDependencies();

  runApp(
    getIt<Kubo>(),
  );
}

@lazySingleton
class Kubo extends StatelessWidget {
  const Kubo({
    required this.appRouter,
    required this.localStorageService,
  }) : super(key: null);

  final AppRouter appRouter;
  final LocalStorageService localStorageService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AgendaCubit()),
        BlocProvider(
          create: (_) => MealPlanCubit(),
        ),
        BlocProvider(
          create: (_) => MenuCubit(
            menuRepository: MenuRepository(
              localStorageService: localStorageService,
            ),
          ),
        ),
        BlocProvider(
          create: (_) => MenuHistoryCubit(
            menuHistoryRepositories: MenuHistoryRepositories(
              localStorageService: localStorageService,
            ),
          ),
        ),
      ],
      child: MaterialApp(
        initialRoute: SplashPage.id,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
