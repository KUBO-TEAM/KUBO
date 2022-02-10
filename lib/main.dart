import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kubo/config/router.dart';
import 'package:kubo/core/walk_through/splash_screen.dart';
import 'package:kubo/modules/agenda/bloc/agenda_cubit.dart';
import 'package:kubo/modules/menu/repositories/menu_repository.dart';
import 'package:kubo/modules/menu_history/bloc/menu_history_cubit.dart';
import 'package:kubo/modules/menu_history/repositories/menu_history_repositories.dart';
import 'package:kubo/utils/hive/adapters/color.adapter.dart';
import 'package:kubo/utils/hive/objects/schedule.hive.dart';
import 'package:kubo/utils/services/local_storage_service.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'modules/meal_plan/bloc/meal_plan_cubit.dart';
import 'modules/menu/bloc/menu_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await path_provider.getApplicationDocumentsDirectory();

  Hive
    ..init(directory.path)
    ..registerAdapter(ColorAdapter())
    ..registerAdapter(ScheduleHiveAdapter());

  runApp(
    Kubo(
      appRouter: AppRouter(),
      localStorageService: LocalStorageService(),
    ),
  );
}

class Kubo extends StatelessWidget {
  const Kubo({
    Key? key,
    required this.appRouter,
    required this.localStorageService,
  }) : super(key: key);

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
        initialRoute: SplashScreen.id,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
