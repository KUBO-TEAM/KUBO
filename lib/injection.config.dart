// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i4;
import 'package:http/http.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;

import 'core/helpers/date_converter.dart' as _i8;
import 'core/hive/box_module.dart' as _i40;
import 'core/hive/remote_module.dart' as _i41;
import 'features/food_planner/data/datasources/recipe_local_data_source.dart'
    as _i10;
import 'features/food_planner/data/datasources/recipe_schedule_local_data_source.dart'
    as _i11;
import 'features/food_planner/data/datasources/recipes_remote_data_source.dart'
    as _i14;
import 'features/food_planner/data/datasources/reminder_remote_data_source.dart'
    as _i15;
import 'features/food_planner/data/repositories/recipe_repository_impl.dart'
    as _i31;
import 'features/food_planner/data/repositories/recipe_schedule_repository_impl.dart'
    as _i13;
import 'features/food_planner/data/repositories/reminder_repository_impl.dart'
    as _i17;
import 'features/food_planner/domain/entities/recipe.dart' as _i6;
import 'features/food_planner/domain/entities/recipe_schedule.dart' as _i5;
import 'features/food_planner/domain/repositories/recipe_repository.dart'
    as _i30;
import 'features/food_planner/domain/repositories/recipe_schedule_repository.dart'
    as _i12;
import 'features/food_planner/domain/repositories/reminder_repository.dart'
    as _i16;
import 'features/food_planner/domain/usecases/create_cache_recipe.dart' as _i33;
import 'features/food_planner/domain/usecases/create_recipe_schedule.dart'
    as _i21;
import 'features/food_planner/domain/usecases/fetch_cached_recipes.dart'
    as _i34;
import 'features/food_planner/domain/usecases/fetch_filtered_recipes.dart'
    as _i35;
import 'features/food_planner/domain/usecases/fetch_notifications.dart' as _i24;
import 'features/food_planner/domain/usecases/fetch_recipe.dart' as _i36;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart'
    as _i22;
import 'features/food_planner/domain/usecases/fetch_recipe_schedules.dart'
    as _i23;
import 'features/food_planner/domain/usecases/fetch_recipes.dart' as _i37;
import 'features/food_planner/presentation/blocs/menu/menu_bloc.dart' as _i38;
import 'features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart'
    as _i25;
import 'features/food_planner/presentation/blocs/recipe/recipe_bloc.dart'
    as _i39;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart'
    as _i28;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart'
    as _i29;
import 'features/food_planner/presentation/blocs/reminder/reminder_bloc.dart'
    as _i32;
import 'features/smart_recipe_selection/data/datasources/smart_recipe_selection_remote_data_source.dart'
    as _i18;
import 'features/smart_recipe_selection/data/repositories/smart_recipe_selection_repository_impl.dart'
    as _i20;
import 'features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart'
    as _i19;
import 'features/smart_recipe_selection/domain/usecases/predict_image.dart'
    as _i26;
import 'features/smart_recipe_selection/presentation/blocs/predict_image/predict_image_bloc.dart'
    as _i27;
import 'main.dart' as _i9;
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
  gh.factory<_i7.Client>(() => remoteModule.prefs);
  gh.lazySingleton<_i8.DateConverter>(() => _i8.DateConverter());
  gh.lazySingleton<_i9.Kubo>(() => _i9.Kubo(appRouter: get<_i3.AppRouter>()));
  gh.lazySingleton<_i10.RecipeLocalDataSource>(() =>
      _i10.RecipeLocalDataSourceImpl(recipeBox: get<_i4.Box<_i6.Recipe>>()));
  gh.lazySingleton<_i11.RecipeScheduleLocalDataSource>(() =>
      _i11.RecipeScheduleLocalDataSourceImpl(
          recipeScheduleBox: get<_i4.Box<_i5.RecipeSchedule>>()));
  gh.lazySingleton<_i12.RecipeScheduleRepository>(() =>
      _i13.RecipeScheduleRepositoryImpl(
          recipeLocalDataSource: get<_i11.RecipeScheduleLocalDataSource>()));
  gh.lazySingleton<_i14.RecipesRemoteDataSource>(
      () => _i14.RecipesRemoteDataSourceImpl(client: get<_i7.Client>()));
  gh.lazySingleton<_i15.ReminderRemoteDataSource>(
      () => _i15.ReminderRemoteDataSourceImpl(client: get<_i7.Client>()));
  gh.lazySingleton<_i16.ReminderRepository>(
      () => _i17.ReminderRepositoryImpl(get<_i15.ReminderRemoteDataSource>()));
  gh.lazySingleton<_i18.SmartRecipeSelectionRemoteDataSource>(
      () => _i18.SmartRecipeSelectionRemoteDataSourceImpl());
  gh.lazySingleton<_i19.SmartRecipeSelectionRepository>(() =>
      _i20.SmartRecipeSelectionRepositoryImpl(
          get<_i18.SmartRecipeSelectionRemoteDataSource>()));
  gh.lazySingleton<_i21.CreateRecipeSchedule>(
      () => _i21.CreateRecipeSchedule(get<_i12.RecipeScheduleRepository>()));
  gh.lazySingleton<_i22.FetchRecipeScheduleLinkedHashMap>(() =>
      _i22.FetchRecipeScheduleLinkedHashMap(
          get<_i12.RecipeScheduleRepository>()));
  gh.lazySingleton<_i23.FetchRecipeSchedules>(
      () => _i23.FetchRecipeSchedules(get<_i12.RecipeScheduleRepository>()));
  gh.lazySingleton<_i24.FetchReminders>(
      () => _i24.FetchReminders(get<_i16.ReminderRepository>()));
  gh.factory<_i25.MenuHistoryBloc>(() => _i25.MenuHistoryBloc(
      fetchRecipeScheduleLinkedHashMap:
          get<_i22.FetchRecipeScheduleLinkedHashMap>()));
  gh.lazySingleton<_i26.PredictImage>(
      () => _i26.PredictImage(get<_i19.SmartRecipeSelectionRepository>()));
  gh.factory<_i27.PredictImageBloc>(
      () => _i27.PredictImageBloc(predictImage: get<_i26.PredictImage>()));
  gh.factory<_i28.RecipeInfoCreateRecipeScheduleBloc>(() =>
      _i28.RecipeInfoCreateRecipeScheduleBloc(
          createRecipeSchedule: get<_i21.CreateRecipeSchedule>(),
          dateConverter: get<_i8.DateConverter>()));
  gh.factory<_i29.RecipeInfoFetchRecipeSchedulesBloc>(() =>
      _i29.RecipeInfoFetchRecipeSchedulesBloc(
          fetchRecipeSchedules: get<_i23.FetchRecipeSchedules>()));
  gh.lazySingleton<_i30.RecipeRepository>(() => _i31.RecipeRepositoryImpl(
      get<_i14.RecipesRemoteDataSource>(), get<_i10.RecipeLocalDataSource>()));
  gh.factory<_i32.ReminderBloc>(
      () => _i32.ReminderBloc(fetchReminders: get<_i24.FetchReminders>()));
  gh.lazySingleton<_i33.CreateCacheRecipe>(
      () => _i33.CreateCacheRecipe(get<_i30.RecipeRepository>()));
  gh.lazySingleton<_i34.FetchCachedRecipes>(
      () => _i34.FetchCachedRecipes(get<_i30.RecipeRepository>()));
  gh.lazySingleton<_i35.FetchFilteredRecipes>(
      () => _i35.FetchFilteredRecipes(get<_i30.RecipeRepository>()));
  gh.lazySingleton<_i36.FetchRecipe>(
      () => _i36.FetchRecipe(get<_i30.RecipeRepository>()));
  gh.lazySingleton<_i37.FetchRecipes>(
      () => _i37.FetchRecipes(get<_i30.RecipeRepository>()));
  gh.factory<_i38.MenuBloc>(() => _i38.MenuBloc(
      fetchRecipeSchedules: get<_i23.FetchRecipeSchedules>(),
      fetchRecipe: get<_i36.FetchRecipe>()));
  gh.factory<_i39.RecipeBloc>(() => _i39.RecipeBloc(
      fetchRecipes: get<_i37.FetchRecipes>(),
      fetchFilteredRecipes: get<_i35.FetchFilteredRecipes>(),
      createCacheRecipe: get<_i33.CreateCacheRecipe>(),
      fetchCachedRecipes: get<_i34.FetchCachedRecipes>()));
  return get;
}

class _$BoxModule extends _i40.BoxModule {}

class _$RemoteModule extends _i41.RemoteModule {}
