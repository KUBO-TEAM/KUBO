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
    as _i13;
import 'features/food_planner/data/models/recipe_schedule_model.dart' as _i10;
import 'features/food_planner/data/repositories/recipe_repository_impl.dart'
    as _i24;
import 'features/food_planner/data/repositories/recipe_schedule_repository_impl.dart'
    as _i12;
import 'features/food_planner/domain/entities/recipe_schedule.dart' as _i5;
import 'features/food_planner/domain/repositories/recipe_repository.dart'
    as _i23;
import 'features/food_planner/domain/repositories/recipe_schedule_repository.dart'
    as _i11;
import 'features/food_planner/domain/usecases/create_recipe_schedule.dart'
    as _i17;
import 'features/food_planner/domain/usecases/fetch_filtered_recipes.dart'
    as _i25;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart'
    as _i18;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_list.dart'
    as _i19;
import 'features/food_planner/domain/usecases/fetch_recipes.dart' as _i26;
import 'features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart'
    as _i20;
import 'features/food_planner/presentation/blocs/recipe/recipe_bloc.dart'
    as _i27;
import 'features/smart_recipe_selection/data/datasources/smart_recipe_selection_remote_data_source.dart'
    as _i14;
import 'features/smart_recipe_selection/data/repositories/smart_recipe_selection_repository_impl.dart'
    as _i16;
import 'features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart'
    as _i15;
import 'features/smart_recipe_selection/domain/usecases/predict_image.dart'
    as _i21;
import 'features/smart_recipe_selection/presentation/blocs/predict_image/predict_image_bloc.dart'
    as _i22;
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
          recipeScheduleBox: get<_i4.Box<_i10.RecipeScheduleModel>>()));
  gh.lazySingleton<_i11.RecipeScheduleRepository>(() =>
      _i12.RecipeScheduleRepositoryImpl(
          recipeLocalDataSource: get<_i9.RecipeScheduleLocalDataSource>()));
  gh.lazySingleton<_i13.RecipesRemoteDataSource>(
      () => _i13.RecipesRemoteDataSourceImpl(client: get<_i6.Client>()));
  gh.lazySingleton<_i14.SmartRecipeSelectionRemoteDataSource>(
      () => _i14.SmartRecipeSelectionRemoteDataSourceImpl());
  gh.lazySingleton<_i15.SmartRecipeSelectionRepository>(() =>
      _i16.SmartRecipeSelectionRepositoryImpl(
          get<_i14.SmartRecipeSelectionRemoteDataSource>()));
  gh.lazySingleton<_i17.CreateRecipeSchedule>(
      () => _i17.CreateRecipeSchedule(get<_i11.RecipeScheduleRepository>()));
  gh.lazySingleton<_i18.FetchRecipeScheduleLinkedHashMap>(() =>
      _i18.FetchRecipeScheduleLinkedHashMap(
          get<_i11.RecipeScheduleRepository>()));
  gh.lazySingleton<_i19.FetchRecipeScheduleList>(
      () => _i19.FetchRecipeScheduleList(get<_i11.RecipeScheduleRepository>()));
  gh.factory<_i20.MenuHistoryBloc>(() => _i20.MenuHistoryBloc(
      fetchRecipeScheduleLinkedHashMap:
          get<_i18.FetchRecipeScheduleLinkedHashMap>()));
  gh.lazySingleton<_i21.PredictImage>(
      () => _i21.PredictImage(get<_i15.SmartRecipeSelectionRepository>()));
  gh.factory<_i22.PredictImageBloc>(
      () => _i22.PredictImageBloc(predictImage: get<_i21.PredictImage>()));
  gh.lazySingleton<_i23.RecipeRepository>(
      () => _i24.RecipeRepositoryImpl(get<_i13.RecipesRemoteDataSource>()));
  gh.lazySingleton<_i25.FetchFilteredRecipes>(
      () => _i25.FetchFilteredRecipes(get<_i23.RecipeRepository>()));
  gh.lazySingleton<_i26.FetchRecipes>(
      () => _i26.FetchRecipes(get<_i23.RecipeRepository>()));
  gh.factory<_i27.RecipeBloc>(() => _i27.RecipeBloc(
      fetchRecipes: get<_i26.FetchRecipes>(),
      fetchFilteredRecipes: get<_i25.FetchFilteredRecipes>()));
  return get;
}

class _$RecipeScheduleBox extends _i9.RecipeScheduleBox {}

class _$RemoteModule extends _i13.RemoteModule {}
