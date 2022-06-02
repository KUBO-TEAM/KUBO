import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/hive/adapters/color.adapter.dart';
import 'package:kubo/core/widgets/splash_page.dart';
import 'package:kubo/features/food_planner/domain/entities/ingredient.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';
import 'package:kubo/features/food_planner/presentation/blocs/agenda/agenda_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_schedule_delete/recipe_schedule_delete_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_schedule_edit/recipe_schedule_edit_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_updates/recipe_updates_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/today_schedule/today_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/tomorrow_schedule/tomorrow_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/user/user_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu/menu_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe/recipe_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/reminder/reminder_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/your_status/your_status_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/captured_page/save_scanned_ingredients_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/predict_image/predict_image_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/scanned_pictures_list/scanned_pictures_list_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_selection_dialog/recipe_selection_dialog_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/smart_recipe_list/smart_recipe_list_bloc.dart';
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
    ..registerAdapter(IngredientAdapter())
    ..registerAdapter(RecipeAdapter())
    ..registerAdapter(UserAdapter())
    ..registerAdapter(PredictedImageAdapter())
    ..registerAdapter(CategoryAdapter())
    ..registerAdapter(RecipeScheduleAdapter());

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
        BlocProvider(create: (_) => getIt<AgendaBloc>()),
        BlocProvider(create: (_) => getIt<MenuHistoryBloc>()),
        BlocProvider(create: (_) => getIt<RecipeBloc>()),
        BlocProvider(
          create: (_) => getIt<RecipeInfoCreateRecipeScheduleBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<RecipeInfoFetchRecipeSchedulesBloc>(),
        ),
        BlocProvider(create: (_) => getIt<PredictImageBloc>()),
        BlocProvider(create: (_) => getIt<ReminderBloc>()),
        BlocProvider(create: (_) => getIt<UserBloc>()),
        BlocProvider(create: (_) => getIt<SaveScannedIngredientsBloc>()),
        BlocProvider(create: (_) => getIt<ScannedPicturesListBloc>()),
        BlocProvider(create: (_) => getIt<RecipeSelectionDialogBloc>()),
        BlocProvider(create: (_) => getIt<SmartRecipeListBloc>()),
        BlocProvider(create: (_) => getIt<TodayScheduleBloc>()),
        BlocProvider(create: (_) => getIt<TomorrowScheduleBloc>()),
        BlocProvider(create: (_) => getIt<YourStatusBloc>()),
        BlocProvider(create: (_) => getIt<RecipeUpdatesBloc>()),
        BlocProvider(create: (_) => getIt<RecipeScheduleDeleteBloc>()),
        BlocProvider(create: (_) => getIt<RecipeScheduleEditBloc>()),
        BlocProvider(create: (_) => CreateRecipeScheduleDialogBloc()),
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
