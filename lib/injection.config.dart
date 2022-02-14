// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/helpers/date_converter.dart' as _i6;
import 'core/temp/local_storage_service.dart' as _i7;
import 'features/food_planner/data/datasources/recipe_schedule_local_data_source.dart'
    as _i9;
import 'features/food_planner/data/repositories/recipe_schedule_repository_impl.dart'
    as _i10;
import 'features/food_planner/domain/repositories/recipe_schedule_repository.dart'
    as _i5;
import 'features/food_planner/domain/usecases/create_recipe_schedule.dart'
    as _i4;
import 'features/food_planner/presentation/blocs/recipe_schedule_bloc.dart'
    as _i8;
import 'main.dart' as _i11;
import 'router.dart' as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AppRouter>(() => _i3.AppRouter());
  gh.lazySingleton<_i4.CreateRecipeSchedule>(
      () => _i4.CreateRecipeSchedule(get<_i5.RecipeScheduleRepository>()));
  gh.lazySingleton<_i6.DateConverter>(() => _i6.DateConverter());
  gh.lazySingleton<_i7.LocalStorageService>(() => _i7.LocalStorageService());
  gh.factory<_i8.RecipeScheduleBloc>(() => _i8.RecipeScheduleBloc(
      createRecipeSchedule: get<_i4.CreateRecipeSchedule>(),
      dateConverter: get<_i6.DateConverter>()));
  gh.lazySingleton<_i9.RecipeScheduleLocalDataSourceImpl>(
      () => _i9.RecipeScheduleLocalDataSourceImpl());
  gh.lazySingleton<_i10.RecipeScheduleRepositoryImpl>(() =>
      _i10.RecipeScheduleRepositoryImpl(
          localDataSource: get<_i9.RecipeScheduleLocalDataSource>()));
  gh.lazySingleton<_i11.Kubo>(() => _i11.Kubo(
      appRouter: get<_i3.AppRouter>(),
      localStorageService: get<_i7.LocalStorageService>()));
  return get;
}
