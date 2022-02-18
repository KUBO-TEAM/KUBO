// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

import 'core/helpers/date_converter.dart' as _i6;
import 'core/hive/objects/recipe_schedule_hive.dart' as _i5;
import 'features/food_planner/data/datasources/recipe_schedule_local_data_source.dart'
    as _i8;
import 'features/food_planner/data/repositories/recipe_schedule_repository_impl.dart'
    as _i10;
import 'features/food_planner/domain/repositories/recipe_schedule_repository.dart'
    as _i9;
import 'features/food_planner/domain/usecases/create_recipe_schedule.dart'
    as _i11;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart'
    as _i12;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_list.dart'
    as _i13;
import 'features/food_planner/presentation/blocs/menu/menu_bloc.dart' as _i14;
import 'features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart'
    as _i15;
import 'main.dart' as _i7;
import 'router.dart' as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final recipeScheduleBox = _$RecipeScheduleBox();
  gh.lazySingleton<_i3.AppRouter>(() => _i3.AppRouter());
  await gh.factoryAsync<_i4.Box<_i5.RecipeScheduleHive>>(
      () => recipeScheduleBox.recipeSchedule,
      preResolve: true);
  gh.lazySingleton<_i6.DateConverter>(() => _i6.DateConverter());
  gh.lazySingleton<_i7.Kubo>(() => _i7.Kubo(appRouter: get<_i3.AppRouter>()));
  gh.lazySingleton<_i8.RecipeScheduleLocalDataSource>(() =>
      _i8.RecipeScheduleLocalDataSourceImpl(
          recipeScheduleBox: get<_i4.Box<_i5.RecipeScheduleHive>>()));
  gh.lazySingleton<_i9.RecipeScheduleRepository>(() =>
      _i10.RecipeScheduleRepositoryImpl(
          localDataSource: get<_i8.RecipeScheduleLocalDataSource>()));
  gh.lazySingleton<_i11.CreateRecipeSchedule>(
      () => _i11.CreateRecipeSchedule(get<_i9.RecipeScheduleRepository>()));
  gh.lazySingleton<_i12.FetchRecipeScheduleLinkedHashMap>(() =>
      _i12.FetchRecipeScheduleLinkedHashMap(
          get<_i9.RecipeScheduleRepository>()));
  gh.lazySingleton<_i13.FetchRecipeScheduleList>(
      () => _i13.FetchRecipeScheduleList(get<_i9.RecipeScheduleRepository>()));
  gh.factory<_i14.MenuBloc>(() => _i14.MenuBloc(
      createRecipeSchedule: get<_i11.CreateRecipeSchedule>(),
      fetchRecipeScheduleList: get<_i13.FetchRecipeScheduleList>(),
      dateConverter: get<_i6.DateConverter>()));
  gh.factory<_i15.MenuHistoryBloc>(() => _i15.MenuHistoryBloc(
      fetchRecipeScheduleLinkedHashMap:
          get<_i12.FetchRecipeScheduleLinkedHashMap>()));
  return get;
}

class _$RecipeScheduleBox extends _i8.RecipeScheduleBox {}
