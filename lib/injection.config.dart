// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i4;
import 'package:http/http.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;

import 'core/helpers/date_converter.dart' as _i7;
import 'core/hive/objects/recipe_schedule_hive.dart' as _i5;
import 'features/food_planner/data/datasources/recipe_schedule_local_data_source.dart'
    as _i9;
import 'features/food_planner/data/datasources/recipes_remote_data_source.dart'
    as _i12;
import 'features/food_planner/data/repositories/recipe_repository_impl.dart'
    as _i19;
import 'features/food_planner/data/repositories/recipe_schedule_repository_impl.dart'
    as _i11;
import 'features/food_planner/domain/repositories/recipe_repository.dart'
    as _i18;
import 'features/food_planner/domain/repositories/recipe_schedule_repository.dart'
    as _i10;
import 'features/food_planner/domain/usecases/create_recipe_schedule.dart'
    as _i13;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart'
    as _i14;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_list.dart'
    as _i15;
import 'features/food_planner/domain/usecases/fetch_recipes.dart' as _i20;
import 'features/food_planner/presentation/blocs/menu/menu_bloc.dart' as _i16;
import 'features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart'
    as _i17;
import 'features/food_planner/presentation/blocs/recipe/recipe_bloc.dart'
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
  await gh.factoryAsync<_i4.Box<_i5.RecipeScheduleHive>>(
      () => recipeScheduleBox.recipeSchedule,
      preResolve: true);
  gh.factory<_i6.Client>(() => remoteModule.prefs);
  gh.lazySingleton<_i7.DateConverter>(() => _i7.DateConverter());
  gh.lazySingleton<_i8.Kubo>(() => _i8.Kubo(appRouter: get<_i3.AppRouter>()));
  gh.lazySingleton<_i9.RecipeScheduleLocalDataSource>(() =>
      _i9.RecipeScheduleLocalDataSourceImpl(
          recipeScheduleBox: get<_i4.Box<_i5.RecipeScheduleHive>>()));
  gh.lazySingleton<_i10.RecipeScheduleRepository>(() =>
      _i11.RecipeScheduleRepositoryImpl(
          localDataSource: get<_i9.RecipeScheduleLocalDataSource>()));
  gh.lazySingleton<_i12.RecipesRemoteDataSource>(
      () => _i12.RecipesRemoteDataSourceImpl(client: get<_i6.Client>()));
  gh.lazySingleton<_i13.CreateRecipeSchedule>(
      () => _i13.CreateRecipeSchedule(get<_i10.RecipeScheduleRepository>()));
  gh.lazySingleton<_i14.FetchRecipeScheduleLinkedHashMap>(() =>
      _i14.FetchRecipeScheduleLinkedHashMap(
          get<_i10.RecipeScheduleRepository>()));
  gh.lazySingleton<_i15.FetchRecipeScheduleList>(
      () => _i15.FetchRecipeScheduleList(get<_i10.RecipeScheduleRepository>()));
  gh.factory<_i16.MenuBloc>(() => _i16.MenuBloc(
      createRecipeSchedule: get<_i13.CreateRecipeSchedule>(),
      fetchRecipeScheduleList: get<_i15.FetchRecipeScheduleList>(),
      dateConverter: get<_i7.DateConverter>()));
  gh.factory<_i17.MenuHistoryBloc>(() => _i17.MenuHistoryBloc(
      fetchRecipeScheduleLinkedHashMap:
          get<_i14.FetchRecipeScheduleLinkedHashMap>()));
  gh.lazySingleton<_i18.RecipeRepository>(
      () => _i19.RecipeRepositoryImpl(get<_i12.RecipesRemoteDataSource>()));
  gh.lazySingleton<_i20.FetchRecipes>(
      () => _i20.FetchRecipes(get<_i18.RecipeRepository>()));
  gh.factory<_i21.RecipeBloc>(
      () => _i21.RecipeBloc(fetchRecipes: get<_i20.FetchRecipes>()));
  return get;
}

class _$RecipeScheduleBox extends _i9.RecipeScheduleBox {}

class _$RemoteModule extends _i12.RemoteModule {}
