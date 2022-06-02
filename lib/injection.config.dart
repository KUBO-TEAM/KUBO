// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i4;
import 'package:http/http.dart' as _i11;
import 'package:injectable/injectable.dart' as _i2;

import 'core/helpers/date_converter.dart' as _i12;
import 'core/hive/box_module.dart' as _i81;
import 'core/hive/remote_module.dart' as _i82;
import 'features/food_planner/data/datasources/recipe_local_data_source.dart'
    as _i14;
import 'features/food_planner/data/datasources/recipe_schedule_local_data_source.dart'
    as _i15;
import 'features/food_planner/data/datasources/recipes_remote_data_source.dart'
    as _i18;
import 'features/food_planner/data/datasources/reminder_local_data_source.dart'
    as _i19;
import 'features/food_planner/data/datasources/reminder_remote_data_source.dart'
    as _i20;
import 'features/food_planner/data/datasources/user_local_data_source.dart'
    as _i27;
import 'features/food_planner/data/repositories/recipe_repository_impl.dart'
    as _i59;
import 'features/food_planner/data/repositories/recipe_schedule_repository_impl.dart'
    as _i17;
import 'features/food_planner/data/repositories/reminder_repository_impl.dart'
    as _i22;
import 'features/food_planner/data/repositories/user_repository_impl.dart'
    as _i29;
import 'features/food_planner/domain/entities/recipe.dart' as _i6;
import 'features/food_planner/domain/entities/recipe_schedule.dart' as _i5;
import 'features/food_planner/domain/entities/reminder.dart' as _i7;
import 'features/food_planner/domain/entities/user.dart' as _i8;
import 'features/food_planner/domain/repositories/recipe_repository.dart'
    as _i58;
import 'features/food_planner/domain/repositories/recipe_schedule_repository.dart'
    as _i16;
import 'features/food_planner/domain/repositories/reminder_repository.dart'
    as _i21;
import 'features/food_planner/domain/repositories/user_repository.dart' as _i28;
import 'features/food_planner/domain/usecases/create_cache_recipe.dart' as _i71;
import 'features/food_planner/domain/usecases/create_recipe_schedule.dart'
    as _i33;
import 'features/food_planner/domain/usecases/create_recipe_schedule_reminder.dart'
    as _i34;
import 'features/food_planner/domain/usecases/delete_recipe_schedule.dart'
    as _i37;
import 'features/food_planner/domain/usecases/edit_recipe_schedule.dart'
    as _i38;
import 'features/food_planner/domain/usecases/fetch_cached_recipes.dart'
    as _i72;
import 'features/food_planner/domain/usecases/fetch_filtered_recipes.dart'
    as _i73;
import 'features/food_planner/domain/usecases/fetch_latest_recipe.dart' as _i74;
import 'features/food_planner/domain/usecases/fetch_local_reminders.dart'
    as _i41;
import 'features/food_planner/domain/usecases/fetch_recipe.dart' as _i75;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart'
    as _i43;
import 'features/food_planner/domain/usecases/fetch_recipe_schedules.dart'
    as _i44;
import 'features/food_planner/domain/usecases/fetch_recipe_schedules_length.dart'
    as _i45;
import 'features/food_planner/domain/usecases/fetch_recipes.dart' as _i76;
import 'features/food_planner/domain/usecases/fetch_reminders.dart' as _i46;
import 'features/food_planner/domain/usecases/fetch_today_recipe_schedule.dart'
    as _i47;
import 'features/food_planner/domain/usecases/fetch_tomorrow_recipe_schedule.dart'
    as _i48;
import 'features/food_planner/domain/usecases/fetch_upcoming_recipe_schedules.dart'
    as _i49;
import 'features/food_planner/domain/usecases/fetch_user.dart' as _i50;
import 'features/food_planner/domain/usecases/initialize_user.dart' as _i52;
import 'features/food_planner/presentation/blocs/agenda/agenda_bloc.dart'
    as _i80;
import 'features/food_planner/presentation/blocs/menu/menu_bloc.dart' as _i77;
import 'features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart'
    as _i53;
import 'features/food_planner/presentation/blocs/recipe/recipe_bloc.dart'
    as _i78;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart'
    as _i56;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart'
    as _i57;
import 'features/food_planner/presentation/blocs/recipe_schedule_delete/recipe_schedule_delete_bloc.dart'
    as _i60;
import 'features/food_planner/presentation/blocs/recipe_schedule_edit/recipe_schedule_edit_bloc.dart'
    as _i61;
import 'features/food_planner/presentation/blocs/recipe_selection_dialog/recipe_selection_dialog_bloc.dart'
    as _i62;
import 'features/food_planner/presentation/blocs/recipe_updates/recipe_updates_bloc.dart'
    as _i79;
import 'features/food_planner/presentation/blocs/reminder/reminder_bloc.dart'
    as _i63;
import 'features/food_planner/presentation/blocs/today_schedule/today_schedule_bloc.dart'
    as _i67;
import 'features/food_planner/presentation/blocs/tomorrow_schedule/tomorrow_schedule_bloc.dart'
    as _i68;
import 'features/food_planner/presentation/blocs/user/user_bloc.dart' as _i69;
import 'features/food_planner/presentation/blocs/your_status/your_status_bloc.dart'
    as _i70;
import 'features/smart_recipe_selection/data/datasources/smart_recipe_selection_local_data_source.dart'
    as _i23;
import 'features/smart_recipe_selection/data/datasources/smart_recipe_selection_remote_data_source.dart'
    as _i24;
import 'features/smart_recipe_selection/data/repositories/smart_recipe_selection_repository_impl.dart'
    as _i26;
import 'features/smart_recipe_selection/domain/entities/category.dart' as _i9;
import 'features/smart_recipe_selection/domain/entities/predicted_image.dart'
    as _i10;
import 'features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart'
    as _i25;
import 'features/smart_recipe_selection/domain/usecases/create_category.dart'
    as _i30;
import 'features/smart_recipe_selection/domain/usecases/create_generate_recipe_schedules.dart'
    as _i31;
import 'features/smart_recipe_selection/domain/usecases/create_predicted_image.dart'
    as _i32;
import 'features/smart_recipe_selection/domain/usecases/delete_expired_predicted_images.dart'
    as _i35;
import 'features/smart_recipe_selection/domain/usecases/delete_predicted_images.dart'
    as _i36;
import 'features/smart_recipe_selection/domain/usecases/fetch_categories.dart'
    as _i39;
import 'features/smart_recipe_selection/domain/usecases/fetch_predicted_images.dart'
    as _i42;
import 'features/smart_recipe_selection/domain/usecases/fetch_recipe_schedules_length.dart'
    as _i40;
import 'features/smart_recipe_selection/domain/usecases/generate_recipe_schedules.dart'
    as _i51;
import 'features/smart_recipe_selection/domain/usecases/predict_image.dart'
    as _i54;
import 'features/smart_recipe_selection/presentation/blocs/captured_page/save_scanned_ingredients_bloc.dart'
    as _i64;
import 'features/smart_recipe_selection/presentation/blocs/predict_image/predict_image_bloc.dart'
    as _i55;
import 'features/smart_recipe_selection/presentation/blocs/scanned_pictures_list/scanned_pictures_list_bloc.dart'
    as _i65;
import 'features/smart_recipe_selection/presentation/blocs/smart_recipe_list/smart_recipe_list_bloc.dart'
    as _i66;
import 'main.dart' as _i13;
import 'router.dart' as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final boxModule = _$BoxModule();
  final remoteModule = _$RemoteModule();
  gh.lazySingleton<_i3.AppRouter>(() => _i3.AppRouter());
  await gh.factoryAsync<_i4.Box<_i5.RecipeSchedule>>(
      () => boxModule.recipeSchedule,
      preResolve: true);
  await gh.factoryAsync<_i4.Box<_i6.Recipe>>(() => boxModule.recipe,
      preResolve: true);
  await gh.factoryAsync<_i4.Box<_i7.Reminder>>(() => boxModule.reminder,
      preResolve: true);
  await gh.factoryAsync<_i4.Box<_i8.User>>(() => boxModule.user,
      preResolve: true);
  await gh.factoryAsync<_i4.Box<_i9.Category>>(() => boxModule.category,
      preResolve: true);
  await gh.factoryAsync<_i4.Box<_i10.PredictedImage>>(
      () => boxModule.predictedImage,
      preResolve: true);
  gh.factory<_i11.Client>(() => remoteModule.prefs);
  gh.lazySingleton<_i12.DateConverter>(() => _i12.DateConverter());
  gh.lazySingleton<_i13.Kubo>(() => _i13.Kubo(appRouter: get<_i3.AppRouter>()));
  gh.lazySingleton<_i14.RecipeLocalDataSource>(() =>
      _i14.RecipeLocalDataSourceImpl(recipeBox: get<_i4.Box<_i6.Recipe>>()));
  gh.lazySingleton<_i15.RecipeScheduleLocalDataSource>(() =>
      _i15.RecipeScheduleLocalDataSourceImpl(
          recipeScheduleBox: get<_i4.Box<_i5.RecipeSchedule>>()));
  gh.lazySingleton<_i16.RecipeScheduleRepository>(() =>
      _i17.RecipeScheduleRepositoryImpl(
          recipeScheduleLocalDataSource:
              get<_i15.RecipeScheduleLocalDataSource>()));
  gh.lazySingleton<_i18.RecipesRemoteDataSource>(
      () => _i18.RecipesRemoteDataSourceImpl(client: get<_i11.Client>()));
  gh.lazySingleton<_i19.ReminderLocalDataSource>(() =>
      _i19.ReminderLocalDataSourceImpl(
          reminderBox: get<_i4.Box<_i7.Reminder>>()));
  gh.lazySingleton<_i20.ReminderRemoteDataSource>(
      () => _i20.ReminderRemoteDataSourceImpl(client: get<_i11.Client>()));
  gh.lazySingleton<_i21.ReminderRepository>(() => _i22.ReminderRepositoryImpl(
      reminderRemoteDataSource: get<_i20.ReminderRemoteDataSource>(),
      reminderLocalDataSource: get<_i19.ReminderLocalDataSource>()));
  gh.lazySingleton<_i23.SmartRecipeSelectionLocalDataSource>(() =>
      _i23.SmartRecipeSelectionLocalDataSourceImpl(
          categoryBox: get<_i4.Box<_i9.Category>>(),
          predictedImageBox: get<_i4.Box<_i10.PredictedImage>>(),
          recipeScheduleBox: get<_i4.Box<_i5.RecipeSchedule>>()));
  gh.lazySingleton<_i24.SmartRecipeSelectionRemoteDataSource>(() =>
      _i24.SmartRecipeSelectionRemoteDataSourceImpl(
          client: get<_i11.Client>()));
  gh.lazySingleton<_i25.SmartRecipeSelectionRepository>(() =>
      _i26.SmartRecipeSelectionRepositoryImpl(
          smartRecipeSelectionRemoteDataSource:
              get<_i24.SmartRecipeSelectionRemoteDataSource>(),
          smartRecipeSelectionLocalDataSource:
              get<_i23.SmartRecipeSelectionLocalDataSource>()));
  gh.lazySingleton<_i27.UserLocalDataSource>(
      () => _i27.UserLocalDataSourceImpl(userBox: get<_i4.Box<_i8.User>>()));
  gh.lazySingleton<_i28.UserRepository>(
      () => _i29.UserRepositoryImpl(get<_i27.UserLocalDataSource>()));
  gh.lazySingleton<_i30.CreateCategory>(
      () => _i30.CreateCategory(get<_i25.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i31.CreateGenerateRecipeSchedules>(() =>
      _i31.CreateGenerateRecipeSchedules(
          get<_i25.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i32.CreatePredictedImage>(() =>
      _i32.CreatePredictedImage(get<_i25.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i33.CreateRecipeSchedule>(
      () => _i33.CreateRecipeSchedule(get<_i16.RecipeScheduleRepository>()));
  gh.lazySingleton<_i34.CreateRecipeScheduleReminder>(
      () => _i34.CreateRecipeScheduleReminder(get<_i21.ReminderRepository>()));
  gh.lazySingleton<_i35.DeleteExpiredPredictedImages>(() =>
      _i35.DeleteExpiredPredictedImages(
          get<_i25.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i36.DeletePredictedImages>(() =>
      _i36.DeletePredictedImages(get<_i25.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i37.DeleteRecipeSchedule>(
      () => _i37.DeleteRecipeSchedule(get<_i16.RecipeScheduleRepository>()));
  gh.lazySingleton<_i38.EditRecipeSchedule>(
      () => _i38.EditRecipeSchedule(get<_i16.RecipeScheduleRepository>()));
  gh.lazySingleton<_i39.FetchCategories>(
      () => _i39.FetchCategories(get<_i25.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i40.FetchCategoriesLength>(() =>
      _i40.FetchCategoriesLength(get<_i25.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i41.FetchLocalReminders>(
      () => _i41.FetchLocalReminders(get<_i21.ReminderRepository>()));
  gh.lazySingleton<_i42.FetchPredictedImages>(() =>
      _i42.FetchPredictedImages(get<_i25.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i43.FetchRecipeScheduleLinkedHashMap>(() =>
      _i43.FetchRecipeScheduleLinkedHashMap(
          get<_i16.RecipeScheduleRepository>()));
  gh.lazySingleton<_i44.FetchRecipeSchedules>(
      () => _i44.FetchRecipeSchedules(get<_i16.RecipeScheduleRepository>()));
  gh.lazySingleton<_i45.FetchRecipeSchedulesLength>(() =>
      _i45.FetchRecipeSchedulesLength(get<_i16.RecipeScheduleRepository>()));
  gh.lazySingleton<_i46.FetchReminders>(
      () => _i46.FetchReminders(get<_i21.ReminderRepository>()));
  gh.lazySingleton<_i47.FetchTodaySchedule>(
      () => _i47.FetchTodaySchedule(get<_i16.RecipeScheduleRepository>()));
  gh.lazySingleton<_i48.FetchTomorrowSchedule>(
      () => _i48.FetchTomorrowSchedule(get<_i16.RecipeScheduleRepository>()));
  gh.lazySingleton<_i49.FetchUpcomingRecipeSchedules>(() =>
      _i49.FetchUpcomingRecipeSchedules(get<_i16.RecipeScheduleRepository>()));
  gh.lazySingleton<_i50.FetchUser>(
      () => _i50.FetchUser(get<_i28.UserRepository>()));
  gh.lazySingleton<_i51.GenerateRecipeSchedules>(() =>
      _i51.GenerateRecipeSchedules(get<_i25.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i52.InitializeUser>(
      () => _i52.InitializeUser(get<_i28.UserRepository>()));
  gh.factory<_i53.MenuHistoryBloc>(() => _i53.MenuHistoryBloc(
      fetchRecipeScheduleLinkedHashMap:
          get<_i43.FetchRecipeScheduleLinkedHashMap>()));
  gh.lazySingleton<_i54.PredictImage>(
      () => _i54.PredictImage(get<_i25.SmartRecipeSelectionRepository>()));
  gh.factory<_i55.PredictImageBloc>(
      () => _i55.PredictImageBloc(predictImage: get<_i54.PredictImage>()));
  gh.factory<_i56.RecipeInfoCreateRecipeScheduleBloc>(() =>
      _i56.RecipeInfoCreateRecipeScheduleBloc(
          createRecipeSchedule: get<_i33.CreateRecipeSchedule>(),
          dateConverter: get<_i12.DateConverter>(),
          createRecipeScheduleReminder:
              get<_i34.CreateRecipeScheduleReminder>()));
  gh.factory<_i57.RecipeInfoFetchRecipeSchedulesBloc>(() =>
      _i57.RecipeInfoFetchRecipeSchedulesBloc(
          fetchRecipeSchedules: get<_i44.FetchRecipeSchedules>()));
  gh.lazySingleton<_i58.RecipeRepository>(() => _i59.RecipeRepositoryImpl(
      get<_i18.RecipesRemoteDataSource>(), get<_i14.RecipeLocalDataSource>()));
  gh.factory<_i60.RecipeScheduleDeleteBloc>(() => _i60.RecipeScheduleDeleteBloc(
      deleteRecipeSchedule: get<_i37.DeleteRecipeSchedule>()));
  gh.factory<_i61.RecipeScheduleEditBloc>(() => _i61.RecipeScheduleEditBloc(
      editRecipeSchedule: get<_i38.EditRecipeSchedule>(),
      dateConverter: get<_i12.DateConverter>()));
  gh.factory<_i62.RecipeSelectionDialogBloc>(() =>
      _i62.RecipeSelectionDialogBloc(
          fetchCategories: get<_i39.FetchCategories>()));
  gh.factory<_i63.ReminderBloc>(() => _i63.ReminderBloc(
      fetchReminders: get<_i46.FetchReminders>(),
      fetchLocalReminders: get<_i41.FetchLocalReminders>()));
  gh.factory<_i64.SaveScannedIngredientsBloc>(() =>
      _i64.SaveScannedIngredientsBloc(
          createPredictedImage: get<_i32.CreatePredictedImage>(),
          createCategory: get<_i30.CreateCategory>()));
  gh.factory<_i65.ScannedPicturesListBloc>(() => _i65.ScannedPicturesListBloc(
      fetchPredictedImages: get<_i42.FetchPredictedImages>(),
      deleteExpiredPredictedImages: get<_i35.DeleteExpiredPredictedImages>(),
      deletePredictedImages: get<_i36.DeletePredictedImages>()));
  gh.factory<_i66.SmartRecipeListBloc>(() => _i66.SmartRecipeListBloc(
      generateRecipeSchedules: get<_i51.GenerateRecipeSchedules>(),
      createGenerateRecipeSchedules:
          get<_i31.CreateGenerateRecipeSchedules>()));
  gh.factory<_i67.TodayScheduleBloc>(() => _i67.TodayScheduleBloc(
      fetchTodaySchedule: get<_i47.FetchTodaySchedule>()));
  gh.factory<_i68.TomorrowScheduleBloc>(() => _i68.TomorrowScheduleBloc(
      fetchTomorrowSchedule: get<_i48.FetchTomorrowSchedule>()));
  gh.factory<_i69.UserBloc>(() => _i69.UserBloc(
      fetchUser: get<_i50.FetchUser>(),
      initializeUser: get<_i52.InitializeUser>()));
  gh.factory<_i70.YourStatusBloc>(() => _i70.YourStatusBloc(
      fetchCategoriesLength: get<_i40.FetchCategoriesLength>(),
      fetchRecipeSchedulesLength: get<_i45.FetchRecipeSchedulesLength>()));
  gh.lazySingleton<_i71.CreateCacheRecipe>(
      () => _i71.CreateCacheRecipe(get<_i58.RecipeRepository>()));
  gh.lazySingleton<_i72.FetchCachedRecipes>(
      () => _i72.FetchCachedRecipes(get<_i58.RecipeRepository>()));
  gh.lazySingleton<_i73.FetchFilteredRecipes>(
      () => _i73.FetchFilteredRecipes(get<_i58.RecipeRepository>()));
  gh.lazySingleton<_i74.FetchLatestRecipe>(
      () => _i74.FetchLatestRecipe(get<_i58.RecipeRepository>()));
  gh.lazySingleton<_i75.FetchRecipe>(
      () => _i75.FetchRecipe(get<_i58.RecipeRepository>()));
  gh.lazySingleton<_i76.FetchRecipes>(
      () => _i76.FetchRecipes(get<_i58.RecipeRepository>()));
  gh.factory<_i77.MenuBloc>(() => _i77.MenuBloc(
      fetchUpcomingRecipeSchedules: get<_i49.FetchUpcomingRecipeSchedules>(),
      fetchRecipe: get<_i75.FetchRecipe>()));
  gh.factory<_i78.RecipeBloc>(() => _i78.RecipeBloc(
      fetchRecipes: get<_i76.FetchRecipes>(),
      fetchFilteredRecipes: get<_i73.FetchFilteredRecipes>(),
      createCacheRecipe: get<_i71.CreateCacheRecipe>(),
      fetchCachedRecipes: get<_i72.FetchCachedRecipes>()));
  gh.factory<_i79.RecipeUpdatesBloc>(() =>
      _i79.RecipeUpdatesBloc(fetchLatestRecipe: get<_i74.FetchLatestRecipe>()));
  gh.factory<_i80.AgendaBloc>(() => _i80.AgendaBloc(
      fetchRecipeSchedules: get<_i44.FetchRecipeSchedules>(),
      fetchRecipe: get<_i75.FetchRecipe>()));
  return get;
}

class _$BoxModule extends _i81.BoxModule {}

class _$RemoteModule extends _i82.RemoteModule {}
