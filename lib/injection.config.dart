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
import 'features/food_planner/domain/usecases/get_all_recipe_schedule.dart'
    as _i12;
import 'features/food_planner/presentation/blocs/recipe_schedule/recipe_schedule_bloc.dart'
    as _i13;
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
  gh.lazySingleton<_i12.GetAllRecipeSchedule>(
      () => _i12.GetAllRecipeSchedule(get<_i9.RecipeScheduleRepository>()));
  gh.factory<_i13.RecipeScheduleBloc>(() => _i13.RecipeScheduleBloc(
      createRecipeSchedule: get<_i11.CreateRecipeSchedule>(),
      getAllRecipeSchedule: get<_i12.GetAllRecipeSchedule>(),
      dateConverter: get<_i6.DateConverter>()));
  return get;
}

class _$RecipeScheduleBox extends _i8.RecipeScheduleBox {}
