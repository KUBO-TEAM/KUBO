// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i4;
import 'package:http/http.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;

import 'core/helpers/date_converter.dart' as _i8;
import 'core/hive/box_module.dart' as _i35;
import 'features/food_planner/data/datasources/recipe_local_data_source.dart'
    as _i10;
import 'features/food_planner/data/datasources/recipe_schedule_local_data_source.dart'
    as _i11;
import 'features/food_planner/data/datasources/recipes_remote_data_source.dart'
    as _i14;
import 'features/food_planner/data/repositories/recipe_repository_impl.dart'
    as _i27;
import 'features/food_planner/data/repositories/recipe_schedule_repository_impl.dart'
    as _i13;
import 'features/food_planner/domain/entities/recipe.dart' as _i6;
import 'features/food_planner/domain/entities/recipe_schedule.dart' as _i5;
import 'features/food_planner/domain/repositories/recipe_repository.dart'
    as _i26;
import 'features/food_planner/domain/repositories/recipe_schedule_repository.dart'
    as _i12;
import 'features/food_planner/domain/usecases/create_cache_recipe.dart' as _i28;
import 'features/food_planner/domain/usecases/create_recipe_schedule.dart'
    as _i18;
import 'features/food_planner/domain/usecases/fetch_cached_recipes.dart'
    as _i29;
import 'features/food_planner/domain/usecases/fetch_filtered_recipes.dart'
    as _i30;
import 'features/food_planner/domain/usecases/fetch_recipe.dart' as _i31;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart'
    as _i19;
import 'features/food_planner/domain/usecases/fetch_recipe_schedules.dart'
    as _i20;
import 'features/food_planner/domain/usecases/fetch_recipes.dart' as _i32;
import 'features/food_planner/presentation/blocs/menu/menu_bloc.dart' as _i33;
import 'features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart'
    as _i21;
import 'features/food_planner/presentation/blocs/recipe/recipe_bloc.dart'
    as _i34;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart'
    as _i24;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart'
    as _i25;
import 'features/smart_recipe_selection/data/datasources/smart_recipe_selection_remote_data_source.dart'
    as _i15;
import 'features/smart_recipe_selection/data/repositories/smart_recipe_selection_repository_impl.dart'
    as _i17;
import 'features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart'
    as _i16;
import 'features/smart_recipe_selection/domain/usecases/predict_image.dart'
    as _i22;
import 'features/smart_recipe_selection/presentation/blocs/predict_image/predict_image_bloc.dart'
    as _i23;
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
  gh.lazySingleton<_i15.SmartRecipeSelectionRemoteDataSource>(
      () => _i15.SmartRecipeSelectionRemoteDataSourceImpl());
  gh.lazySingleton<_i16.SmartRecipeSelectionRepository>(() =>
      _i17.SmartRecipeSelectionRepositoryImpl(
          get<_i15.SmartRecipeSelectionRemoteDataSource>()));
  gh.lazySingleton<_i18.CreateRecipeSchedule>(
      () => _i18.CreateRecipeSchedule(get<_i12.RecipeScheduleRepository>()));
  gh.lazySingleton<_i19.FetchRecipeScheduleLinkedHashMap>(() =>
      _i19.FetchRecipeScheduleLinkedHashMap(
          get<_i12.RecipeScheduleRepository>()));
  gh.lazySingleton<_i20.FetchRecipeSchedules>(
      () => _i20.FetchRecipeSchedules(get<_i12.RecipeScheduleRepository>()));
  gh.factory<_i21.MenuHistoryBloc>(() => _i21.MenuHistoryBloc(
      fetchRecipeScheduleLinkedHashMap:
          get<_i19.FetchRecipeScheduleLinkedHashMap>()));
  gh.lazySingleton<_i22.PredictImage>(
      () => _i22.PredictImage(get<_i16.SmartRecipeSelectionRepository>()));
  gh.factory<_i23.PredictImageBloc>(
      () => _i23.PredictImageBloc(predictImage: get<_i22.PredictImage>()));
  gh.factory<_i24.RecipeInfoCreateRecipeScheduleBloc>(() =>
      _i24.RecipeInfoCreateRecipeScheduleBloc(
          createRecipeSchedule: get<_i18.CreateRecipeSchedule>(),
          dateConverter: get<_i8.DateConverter>()));
  gh.factory<_i25.RecipeInfoFetchRecipeSchedulesBloc>(() =>
      _i25.RecipeInfoFetchRecipeSchedulesBloc(
          fetchRecipeSchedules: get<_i20.FetchRecipeSchedules>()));
  gh.lazySingleton<_i26.RecipeRepository>(() => _i27.RecipeRepositoryImpl(
      get<_i14.RecipesRemoteDataSource>(), get<_i10.RecipeLocalDataSource>()));
  gh.lazySingleton<_i28.CreateCacheRecipe>(
      () => _i28.CreateCacheRecipe(get<_i26.RecipeRepository>()));
  gh.lazySingleton<_i29.FetchCachedRecipes>(
      () => _i29.FetchCachedRecipes(get<_i26.RecipeRepository>()));
  gh.lazySingleton<_i30.FetchFilteredRecipes>(
      () => _i30.FetchFilteredRecipes(get<_i26.RecipeRepository>()));
  gh.lazySingleton<_i31.FetchRecipe>(
      () => _i31.FetchRecipe(get<_i26.RecipeRepository>()));
  gh.lazySingleton<_i32.FetchRecipes>(
      () => _i32.FetchRecipes(get<_i26.RecipeRepository>()));
  gh.factory<_i33.MenuBloc>(() => _i33.MenuBloc(
      fetchRecipeSchedules: get<_i20.FetchRecipeSchedules>(),
      fetchRecipe: get<_i31.FetchRecipe>()));
  gh.factory<_i34.RecipeBloc>(() => _i34.RecipeBloc(
      fetchRecipes: get<_i32.FetchRecipes>(),
      fetchFilteredRecipes: get<_i30.FetchFilteredRecipes>(),
      createCacheRecipe: get<_i28.CreateCacheRecipe>(),
      fetchCachedRecipes: get<_i29.FetchCachedRecipes>()));
  return get;
}

class _$BoxModule extends _i35.BoxModule {}

class _$RemoteModule extends _i14.RemoteModule {}
