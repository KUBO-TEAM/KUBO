// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i4;
import 'package:http/http.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;

import 'core/helpers/date_converter.dart' as _i7;
import 'features/food_planner/data/datasources/recipe_schedule_local_data_source.dart'
    as _i9;
import 'features/food_planner/data/datasources/recipes_remote_data_source.dart'
    as _i12;
import 'features/food_planner/data/repositories/recipe_repository_impl.dart'
    as _i25;
import 'features/food_planner/data/repositories/recipe_schedule_repository_impl.dart'
    as _i11;
import 'features/food_planner/domain/entities/recipe_schedule.dart' as _i5;
import 'features/food_planner/domain/repositories/recipe_repository.dart'
    as _i24;
import 'features/food_planner/domain/repositories/recipe_schedule_repository.dart'
    as _i10;
import 'features/food_planner/domain/usecases/create_recipe_schedule.dart'
    as _i16;
import 'features/food_planner/domain/usecases/fetch_filtered_recipes.dart'
    as _i26;
import 'features/food_planner/domain/usecases/fetch_recipe.dart' as _i27;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart'
    as _i17;
import 'features/food_planner/domain/usecases/fetch_recipe_schedules.dart'
    as _i18;
import 'features/food_planner/domain/usecases/fetch_recipes.dart' as _i28;
import 'features/food_planner/presentation/blocs/menu/menu_bloc.dart' as _i29;
import 'features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart'
    as _i19;
import 'features/food_planner/presentation/blocs/recipe/recipe_bloc.dart'
    as _i30;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart'
    as _i22;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart'
    as _i23;
import 'features/smart_recipe_selection/data/datasources/smart_recipe_selection_remote_data_source.dart'
    as _i13;
import 'features/smart_recipe_selection/data/repositories/smart_recipe_selection_repository_impl.dart'
    as _i15;
import 'features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart'
    as _i14;
import 'features/smart_recipe_selection/domain/usecases/predict_image.dart'
    as _i20;
import 'features/smart_recipe_selection/presentation/blocs/predict_image/predict_image_bloc.dart'
    as _i21;
import 'main.dart' as _i8;
import 'router.dart' as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final recipeScheduleBox = _$RecipeScheduleBox();
  final remoteModule = _$RemoteModule();
  gh.lazySingleton<_i3.AppRouter>(() => _i3.AppRouter());
  await gh.factoryAsync<_i4.Box<_i5.RecipeSchedule>>(
      () => recipeScheduleBox.recipeSchedule,
      preResolve: true);
  gh.factory<_i6.Client>(() => remoteModule.prefs);
  gh.lazySingleton<_i7.DateConverter>(() => _i7.DateConverter());
  gh.lazySingleton<_i8.Kubo>(() => _i8.Kubo(appRouter: get<_i3.AppRouter>()));
  gh.lazySingleton<_i9.RecipeScheduleLocalDataSource>(() =>
      _i9.RecipeScheduleLocalDataSourceImpl(
          recipeScheduleBox: get<_i4.Box<_i5.RecipeSchedule>>()));
  gh.lazySingleton<_i10.RecipeScheduleRepository>(() =>
      _i11.RecipeScheduleRepositoryImpl(
          recipeLocalDataSource: get<_i9.RecipeScheduleLocalDataSource>()));
  gh.lazySingleton<_i12.RecipesRemoteDataSource>(
      () => _i12.RecipesRemoteDataSourceImpl(client: get<_i6.Client>()));
  gh.lazySingleton<_i13.SmartRecipeSelectionRemoteDataSource>(
      () => _i13.SmartRecipeSelectionRemoteDataSourceImpl());
  gh.lazySingleton<_i14.SmartRecipeSelectionRepository>(() =>
      _i15.SmartRecipeSelectionRepositoryImpl(
          get<_i13.SmartRecipeSelectionRemoteDataSource>()));
  gh.lazySingleton<_i16.CreateRecipeSchedule>(
      () => _i16.CreateRecipeSchedule(get<_i10.RecipeScheduleRepository>()));
  gh.lazySingleton<_i17.FetchRecipeScheduleLinkedHashMap>(() =>
      _i17.FetchRecipeScheduleLinkedHashMap(
          get<_i10.RecipeScheduleRepository>()));
  gh.lazySingleton<_i18.FetchRecipeSchedules>(
      () => _i18.FetchRecipeSchedules(get<_i10.RecipeScheduleRepository>()));
  gh.factory<_i19.MenuHistoryBloc>(() => _i19.MenuHistoryBloc(
      fetchRecipeScheduleLinkedHashMap:
          get<_i17.FetchRecipeScheduleLinkedHashMap>()));
  gh.lazySingleton<_i20.PredictImage>(
      () => _i20.PredictImage(get<_i14.SmartRecipeSelectionRepository>()));
  gh.factory<_i21.PredictImageBloc>(
      () => _i21.PredictImageBloc(predictImage: get<_i20.PredictImage>()));
  gh.factory<_i22.RecipeInfoCreateRecipeScheduleBloc>(() =>
      _i22.RecipeInfoCreateRecipeScheduleBloc(
          createRecipeSchedule: get<_i16.CreateRecipeSchedule>(),
          dateConverter: get<_i7.DateConverter>()));
  gh.factory<_i23.RecipeInfoFetchRecipeSchedulesBloc>(() =>
      _i23.RecipeInfoFetchRecipeSchedulesBloc(
          fetchRecipeSchedules: get<_i18.FetchRecipeSchedules>()));
  gh.lazySingleton<_i24.RecipeRepository>(
      () => _i25.RecipeRepositoryImpl(get<_i12.RecipesRemoteDataSource>()));
  gh.lazySingleton<_i26.FetchFilteredRecipes>(
      () => _i26.FetchFilteredRecipes(get<_i24.RecipeRepository>()));
  gh.lazySingleton<_i27.FetchRecipe>(
      () => _i27.FetchRecipe(get<_i24.RecipeRepository>()));
  gh.lazySingleton<_i28.FetchRecipes>(
      () => _i28.FetchRecipes(get<_i24.RecipeRepository>()));
  gh.factory<_i29.MenuBloc>(() => _i29.MenuBloc(
      fetchRecipeSchedules: get<_i18.FetchRecipeSchedules>(),
      fetchRecipe: get<_i27.FetchRecipe>()));
  gh.factory<_i30.RecipeBloc>(() => _i30.RecipeBloc(
      fetchRecipes: get<_i28.FetchRecipes>(),
      fetchFilteredRecipes: get<_i26.FetchFilteredRecipes>()));
  return get;
}

class _$RecipeScheduleBox extends _i5.RecipeScheduleBox {}

class _$RemoteModule extends _i12.RemoteModule {}
