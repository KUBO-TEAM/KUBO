import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/hive/adapters/color.adapter.dart';
import 'package:kubo/core/hive/objects/recipe_schedule_hive.dart';
import 'package:kubo/core/widgets/splash_page.dart';
import 'package:kubo/features/food_planner/presentation/blocs/assign_meal/assign_meal_plan_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu/menu_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe/recipe_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/predict_image/predict_image_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/scanned_pictures/scanned_pictures_bloc.dart';
import 'package:kubo/injection.dart';
import 'package:kubo/router.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
        BlocProvider(create: (_) => getIt<MenuBloc>()),
        BlocProvider(create: (_) => getIt<MenuHistoryBloc>()),
        BlocProvider(create: (_) => getIt<RecipeBloc>()),
        BlocProvider(create: (_) => getIt<PredictImageBloc>()),
        BlocProvider(create: (_) => AssignMealPlanBloc()),
        BlocProvider(create: (_) => ScannedPicturesBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          colorScheme: ThemeData.light().colorScheme.copyWith(
                onPrimary: Colors.white, // Color for checkmark in datatable
                primary:
                    kBrownPrimary, // Color used for checkbox fill in datatable
              ),
          checkboxTheme: CheckboxThemeData(
            side: MaterialStateBorderSide.resolveWith(
                (_) => const BorderSide(width: 2, color: kBrownPrimary)),
            fillColor: MaterialStateProperty.all(kBrownPrimary),
            checkColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        initialRoute: SplashPage.id,
        onGenerateRoute: appRouter.onGenerateRoute,
        builder: EasyLoading.init(),
      ),
    );
  }
}
