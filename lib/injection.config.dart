// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i4;
import 'package:http/http.dart' as _i10;
import 'package:injectable/injectable.dart' as _i2;

import 'core/helpers/date_converter.dart' as _i11;
import 'core/hive/box_module.dart' as _i77;
import 'core/hive/remote_module.dart' as _i78;
import 'features/food_planner/data/datasources/recipe_local_data_source.dart'
    as _i13;
import 'features/food_planner/data/datasources/recipe_schedule_local_data_source.dart'
    as _i14;
import 'features/food_planner/data/datasources/recipes_remote_data_source.dart'
    as _i17;
import 'features/food_planner/data/datasources/reminder_remote_data_source.dart'
    as _i18;
import 'features/food_planner/data/datasources/user_local_data_source.dart'
    as _i25;
import 'features/food_planner/data/repositories/recipe_repository_impl.dart'
    as _i55;
import 'features/food_planner/data/repositories/recipe_schedule_repository_impl.dart'
    as _i16;
import 'features/food_planner/data/repositories/reminder_repository_impl.dart'
    as _i20;
import 'features/food_planner/data/repositories/user_repository_impl.dart'
    as _i27;
import 'features/food_planner/domain/entities/recipe.dart' as _i6;
import 'features/food_planner/domain/entities/recipe_schedule.dart' as _i5;
import 'features/food_planner/domain/entities/user.dart' as _i7;
import 'features/food_planner/domain/repositories/recipe_repository.dart'
    as _i54;
import 'features/food_planner/domain/repositories/recipe_schedule_repository.dart'
    as _i15;
import 'features/food_planner/domain/repositories/reminder_repository.dart'
    as _i19;
import 'features/food_planner/domain/repositories/user_repository.dart' as _i26;
import 'features/food_planner/domain/usecases/create_cache_recipe.dart' as _i67;
import 'features/food_planner/domain/usecases/create_recipe_schedule.dart'
    as _i31;
import 'features/food_planner/domain/usecases/delete_recipe_schedule.dart'
    as _i34;
import 'features/food_planner/domain/usecases/edit_recipe_schedule.dart'
    as _i35;
import 'features/food_planner/domain/usecases/fetch_cached_recipes.dart'
    as _i68;
import 'features/food_planner/domain/usecases/fetch_filtered_recipes.dart'
    as _i69;
import 'features/food_planner/domain/usecases/fetch_latest_recipe.dart' as _i70;
import 'features/food_planner/domain/usecases/fetch_recipe.dart' as _i71;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart'
    as _i39;
import 'features/food_planner/domain/usecases/fetch_recipe_schedules.dart'
    as _i40;
import 'features/food_planner/domain/usecases/fetch_recipe_schedules_length.dart'
    as _i41;
import 'features/food_planner/domain/usecases/fetch_recipes.dart' as _i72;
import 'features/food_planner/domain/usecases/fetch_reminders.dart' as _i42;
import 'features/food_planner/domain/usecases/fetch_today_recipe_schedule.dart'
    as _i43;
import 'features/food_planner/domain/usecases/fetch_tomorrow_recipe_schedule.dart'
    as _i44;
import 'features/food_planner/domain/usecases/fetch_upcoming_recipe_schedules.dart'
    as _i45;
import 'features/food_planner/domain/usecases/fetch_user.dart' as _i46;
import 'features/food_planner/domain/usecases/initialize_user.dart' as _i48;
import 'features/food_planner/presentation/blocs/agenda/agenda_bloc.dart'
    as _i76;
import 'features/food_planner/presentation/blocs/menu/menu_bloc.dart' as _i73;
import 'features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart'
    as _i49;
import 'features/food_planner/presentation/blocs/recipe/recipe_bloc.dart'
    as _i74;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart'
    as _i52;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart'
    as _i53;
import 'features/food_planner/presentation/blocs/recipe_schedule_delete/recipe_schedule_delete_bloc.dart'
    as _i56;
import 'features/food_planner/presentation/blocs/recipe_schedule_edit/recipe_schedule_edit_bloc.dart'
    as _i57;
import 'features/food_planner/presentation/blocs/recipe_selection_dialog/recipe_selection_dialog_bloc.dart'
    as _i58;
import 'features/food_planner/presentation/blocs/recipe_updates/recipe_updates_bloc.dart'
    as _i75;
import 'features/food_planner/presentation/blocs/reminder/reminder_bloc.dart'
    as _i59;
import 'features/food_planner/presentation/blocs/today_schedule/today_schedule_bloc.dart'
    as _i63;
import 'features/food_planner/presentation/blocs/tomorrow_schedule/tomorrow_schedule_bloc.dart'
    as _i64;
import 'features/food_planner/presentation/blocs/user/user_bloc.dart' as _i65;
import 'features/food_planner/presentation/blocs/your_status/your_status_bloc.dart'
    as _i66;
import 'features/smart_recipe_selection/data/datasources/smart_recipe_selection_local_data_source.dart'
    as _i21;
import 'features/smart_recipe_selection/data/datasources/smart_recipe_selection_remote_data_source.dart'
    as _i22;
import 'features/smart_recipe_selection/data/repositories/smart_recipe_selection_repository_impl.dart'
    as _i24;
import 'features/smart_recipe_selection/domain/entities/category.dart' as _i8;
import 'features/smart_recipe_selection/domain/entities/predicted_image.dart'
    as _i9;
import 'features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart'
    as _i23;
import 'features/smart_recipe_selection/domain/usecases/create_category.dart'
    as _i28;
import 'features/smart_recipe_selection/domain/usecases/create_generate_recipe_schedules.dart'
    as _i29;
import 'features/smart_recipe_selection/domain/usecases/create_predicted_image.dart'
    as _i30;
import 'features/smart_recipe_selection/domain/usecases/delete_expired_predicted_images.dart'
    as _i32;
import 'features/smart_recipe_selection/domain/usecases/delete_predicted_images.dart'
    as _i33;
import 'features/smart_recipe_selection/domain/usecases/fetch_categories.dart'
    as _i36;
import 'features/smart_recipe_selection/domain/usecases/fetch_predicted_images.dart'
    as _i38;
import 'features/smart_recipe_selection/domain/usecases/fetch_recipe_schedules_length.dart'
    as _i37;
import 'features/smart_recipe_selection/domain/usecases/generate_recipe_schedules.dart'
    as _i47;
import 'features/smart_recipe_selection/domain/usecases/predict_image.dart'
    as _i50;
import 'features/smart_recipe_selection/presentation/blocs/captured_page/save_scanned_ingredients_bloc.dart'
    as _i60;
import 'features/smart_recipe_selection/presentation/blocs/predict_image/predict_image_bloc.dart'
    as _i51;
import 'features/smart_recipe_selection/presentation/blocs/scanned_pictures_list/scanned_pictures_list_bloc.dart'
    as _i61;
import 'features/smart_recipe_selection/presentation/blocs/smart_recipe_list/smart_recipe_list_bloc.dart'
    as _i62;
import 'main.dart' as _i12;
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
  await gh.factoryAsync<_i4.Box<_i7.User>>(() => boxModule.user,
      preResolve: true);
  await gh.factoryAsync<_i4.Box<_i8.Category>>(() => boxModule.category,
      preResolve: true);
  await gh.factoryAsync<_i4.Box<_i9.PredictedImage>>(
      () => boxModule.predictedImage,
      preResolve: true);
  gh.factory<_i10.Client>(() => remoteModule.prefs);
  gh.lazySingleton<_i11.DateConverter>(() => _i11.DateConverter());
  gh.lazySingleton<_i12.Kubo>(() => _i12.Kubo(appRouter: get<_i3.AppRouter>()));
  gh.lazySingleton<_i13.RecipeLocalDataSource>(() =>
      _i13.RecipeLocalDataSourceImpl(recipeBox: get<_i4.Box<_i6.Recipe>>()));
  gh.lazySingleton<_i14.RecipeScheduleLocalDataSource>(() =>
      _i14.RecipeScheduleLocalDataSourceImpl(
          recipeScheduleBox: get<_i4.Box<_i5.RecipeSchedule>>()));
  gh.lazySingleton<_i15.RecipeScheduleRepository>(() =>
      _i16.RecipeScheduleRepositoryImpl(
          recipeScheduleLocalDataSource:
              get<_i14.RecipeScheduleLocalDataSource>()));
  gh.lazySingleton<_i17.RecipesRemoteDataSource>(
      () => _i17.RecipesRemoteDataSourceImpl(client: get<_i10.Client>()));
  gh.lazySingleton<_i18.ReminderRemoteDataSource>(
      () => _i18.ReminderRemoteDataSourceImpl(client: get<_i10.Client>()));
  gh.lazySingleton<_i19.ReminderRepository>(
      () => _i20.ReminderRepositoryImpl(get<_i18.ReminderRemoteDataSource>()));
  gh.lazySingleton<_i21.SmartRecipeSelectionLocalDataSource>(() =>
      _i21.SmartRecipeSelectionLocalDataSourceImpl(
          categoryBox: get<_i4.Box<_i8.Category>>(),
          predictedImageBox: get<_i4.Box<_i9.PredictedImage>>(),
          recipeScheduleBox: get<_i4.Box<_i5.RecipeSchedule>>()));
  gh.lazySingleton<_i22.SmartRecipeSelectionRemoteDataSource>(() =>
      _i22.SmartRecipeSelectionRemoteDataSourceImpl(
          client: get<_i10.Client>()));
  gh.lazySingleton<_i23.SmartRecipeSelectionRepository>(() =>
      _i24.SmartRecipeSelectionRepositoryImpl(
          smartRecipeSelectionRemoteDataSource:
              get<_i22.SmartRecipeSelectionRemoteDataSource>(),
          smartRecipeSelectionLocalDataSource:
              get<_i21.SmartRecipeSelectionLocalDataSource>()));
  gh.lazySingleton<_i25.UserLocalDataSource>(
      () => _i25.UserLocalDataSourceImpl(userBox: get<_i4.Box<_i7.User>>()));
  gh.lazySingleton<_i26.UserRepository>(
      () => _i27.UserRepositoryImpl(get<_i25.UserLocalDataSource>()));
  gh.lazySingleton<_i28.CreateCategory>(
      () => _i28.CreateCategory(get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i29.CreateGenerateRecipeSchedules>(() =>
      _i29.CreateGenerateRecipeSchedules(
          get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i30.CreatePredictedImage>(() =>
      _i30.CreatePredictedImage(get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i31.CreateRecipeSchedule>(
      () => _i31.CreateRecipeSchedule(get<_i15.RecipeScheduleRepository>()));
  gh.lazySingleton<_i32.DeleteExpiredPredictedImages>(() =>
      _i32.DeleteExpiredPredictedImages(
          get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i33.DeletePredictedImages>(() =>
      _i33.DeletePredictedImages(get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i34.DeleteRecipeSchedule>(
      () => _i34.DeleteRecipeSchedule(get<_i15.RecipeScheduleRepository>()));
  gh.lazySingleton<_i35.EditRecipeSchedule>(
      () => _i35.EditRecipeSchedule(get<_i15.RecipeScheduleRepository>()));
  gh.lazySingleton<_i36.FetchCategories>(
      () => _i36.FetchCategories(get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i37.FetchCategoriesLength>(() =>
      _i37.FetchCategoriesLength(get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i38.FetchPredictedImages>(() =>
      _i38.FetchPredictedImages(get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i39.FetchRecipeScheduleLinkedHashMap>(() =>
      _i39.FetchRecipeScheduleLinkedHashMap(
          get<_i15.RecipeScheduleRepository>()));
  gh.lazySingleton<_i40.FetchRecipeSchedules>(
      () => _i40.FetchRecipeSchedules(get<_i15.RecipeScheduleRepository>()));
  gh.lazySingleton<_i41.FetchRecipeSchedulesLength>(() =>
      _i41.FetchRecipeSchedulesLength(get<_i15.RecipeScheduleRepository>()));
  gh.lazySingleton<_i42.FetchReminders>(
      () => _i42.FetchReminders(get<_i19.ReminderRepository>()));
  gh.lazySingleton<_i43.FetchTodaySchedule>(
      () => _i43.FetchTodaySchedule(get<_i15.RecipeScheduleRepository>()));
  gh.lazySingleton<_i44.FetchTomorrowSchedule>(
      () => _i44.FetchTomorrowSchedule(get<_i15.RecipeScheduleRepository>()));
  gh.lazySingleton<_i45.FetchUpcomingRecipeSchedules>(() =>
      _i45.FetchUpcomingRecipeSchedules(get<_i15.RecipeScheduleRepository>()));
  gh.lazySingleton<_i46.FetchUser>(
      () => _i46.FetchUser(get<_i26.UserRepository>()));
  gh.lazySingleton<_i47.GenerateRecipeSchedules>(() =>
      _i47.GenerateRecipeSchedules(get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i48.InitializeUser>(
      () => _i48.InitializeUser(get<_i26.UserRepository>()));
  gh.factory<_i49.MenuHistoryBloc>(() => _i49.MenuHistoryBloc(
      fetchRecipeScheduleLinkedHashMap:
          get<_i39.FetchRecipeScheduleLinkedHashMap>()));
  gh.lazySingleton<_i50.PredictImage>(
      () => _i50.PredictImage(get<_i23.SmartRecipeSelectionRepository>()));
  gh.factory<_i51.PredictImageBloc>(
      () => _i51.PredictImageBloc(predictImage: get<_i50.PredictImage>()));
  gh.factory<_i52.RecipeInfoCreateRecipeScheduleBloc>(() =>
      _i52.RecipeInfoCreateRecipeScheduleBloc(
          createRecipeSchedule: get<_i31.CreateRecipeSchedule>(),
          dateConverter: get<_i11.DateConverter>()));
  gh.factory<_i53.RecipeInfoFetchRecipeSchedulesBloc>(() =>
      _i53.RecipeInfoFetchRecipeSchedulesBloc(
          fetchRecipeSchedules: get<_i40.FetchRecipeSchedules>()));
  gh.lazySingleton<_i54.RecipeRepository>(() => _i55.RecipeRepositoryImpl(
      get<_i17.RecipesRemoteDataSource>(), get<_i13.RecipeLocalDataSource>()));
  gh.factory<_i56.RecipeScheduleDeleteBloc>(() => _i56.RecipeScheduleDeleteBloc(
      deleteRecipeSchedule: get<_i34.DeleteRecipeSchedule>()));
  gh.factory<_i57.RecipeScheduleEditBloc>(() => _i57.RecipeScheduleEditBloc(
      editRecipeSchedule: get<_i35.EditRecipeSchedule>(),
      dateConverter: get<_i11.DateConverter>()));
  gh.factory<_i58.RecipeSelectionDialogBloc>(() =>
      _i58.RecipeSelectionDialogBloc(
          fetchCategories: get<_i36.FetchCategories>()));
  gh.factory<_i59.ReminderBloc>(
      () => _i59.ReminderBloc(fetchReminders: get<_i42.FetchReminders>()));
  gh.factory<_i60.SaveScannedIngredientsBloc>(() =>
      _i60.SaveScannedIngredientsBloc(
          createPredictedImage: get<_i30.CreatePredictedImage>(),
          createCategory: get<_i28.CreateCategory>()));
  gh.factory<_i61.ScannedPicturesListBloc>(() => _i61.ScannedPicturesListBloc(
      fetchPredictedImages: get<_i38.FetchPredictedImages>(),
      deleteExpiredPredictedImages: get<_i32.DeleteExpiredPredictedImages>(),
      deletePredictedImages: get<_i33.DeletePredictedImages>()));
  gh.factory<_i62.SmartRecipeListBloc>(() => _i62.SmartRecipeListBloc(
      generateRecipeSchedules: get<_i47.GenerateRecipeSchedules>(),
      createGenerateRecipeSchedules:
          get<_i29.CreateGenerateRecipeSchedules>()));
  gh.factory<_i63.TodayScheduleBloc>(() => _i63.TodayScheduleBloc(
      fetchTodaySchedule: get<_i43.FetchTodaySchedule>()));
  gh.factory<_i64.TomorrowScheduleBloc>(() => _i64.TomorrowScheduleBloc(
      fetchTomorrowSchedule: get<_i44.FetchTomorrowSchedule>()));
  gh.factory<_i65.UserBloc>(() => _i65.UserBloc(
      fetchUser: get<_i46.FetchUser>(),
      initializeUser: get<_i48.InitializeUser>()));
  gh.factory<_i66.YourStatusBloc>(() => _i66.YourStatusBloc(
      fetchCategoriesLength: get<_i37.FetchCategoriesLength>(),
      fetchRecipeSchedulesLength: get<_i41.FetchRecipeSchedulesLength>()));
  gh.lazySingleton<_i67.CreateCacheRecipe>(
      () => _i67.CreateCacheRecipe(get<_i54.RecipeRepository>()));
  gh.lazySingleton<_i68.FetchCachedRecipes>(
      () => _i68.FetchCachedRecipes(get<_i54.RecipeRepository>()));
  gh.lazySingleton<_i69.FetchFilteredRecipes>(
      () => _i69.FetchFilteredRecipes(get<_i54.RecipeRepository>()));
  gh.lazySingleton<_i70.FetchLatestRecipe>(
      () => _i70.FetchLatestRecipe(get<_i54.RecipeRepository>()));
  gh.lazySingleton<_i71.FetchRecipe>(
      () => _i71.FetchRecipe(get<_i54.RecipeRepository>()));
  gh.lazySingleton<_i72.FetchRecipes>(
      () => _i72.FetchRecipes(get<_i54.RecipeRepository>()));
  gh.factory<_i73.MenuBloc>(() => _i73.MenuBloc(
      fetchUpcomingRecipeSchedules: get<_i45.FetchUpcomingRecipeSchedules>(),
      fetchRecipe: get<_i71.FetchRecipe>()));
  gh.factory<_i74.RecipeBloc>(() => _i74.RecipeBloc(
      fetchRecipes: get<_i72.FetchRecipes>(),
      fetchFilteredRecipes: get<_i69.FetchFilteredRecipes>(),
      createCacheRecipe: get<_i67.CreateCacheRecipe>(),
      fetchCachedRecipes: get<_i68.FetchCachedRecipes>()));
  gh.factory<_i75.RecipeUpdatesBloc>(() =>
      _i75.RecipeUpdatesBloc(fetchLatestRecipe: get<_i70.FetchLatestRecipe>()));
  gh.factory<_i76.AgendaBloc>(() => _i76.AgendaBloc(
      fetchRecipeSchedules: get<_i40.FetchRecipeSchedules>(),
      fetchRecipe: get<_i71.FetchRecipe>()));
  return get;
}

class _$BoxModule extends _i77.BoxModule {}

class _$RemoteModule extends _i78.RemoteModule {}
