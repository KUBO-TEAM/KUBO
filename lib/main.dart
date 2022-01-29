import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kubo/config/router.dart';
import 'package:kubo/core/adapters/color.adapter.dart';
import 'package:kubo/core/models/schedule.hive.dart';
import 'package:kubo/core/walk_through/splash_screen.dart';
import 'package:kubo/modules/agenda/bloc/agenda_cubit.dart';
import 'package:kubo/modules/menu/bloc/menu_repository.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'core/services/schedule_service.dart';
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
      scheduleService: ScheduleService(),
    ),
  );
}

class Kubo extends StatelessWidget {
  const Kubo({
    Key? key,
    required this.appRouter,
    required this.scheduleService,
  }) : super(key: key);

  final AppRouter appRouter;
  final ScheduleService scheduleService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AgendaCubit()),
        BlocProvider(
          create: (_) => MenuCubit(
            menuRepository: MenuRepository(
              scheduleService: scheduleService,
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
