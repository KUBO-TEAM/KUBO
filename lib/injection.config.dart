// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/temp/local_storage_service.dart' as _i4;
import 'features/food_planner/data/datasources/recipe_schedule_local_data_source.dart'
    as _i5;
import 'main.dart' as _i6;
import 'router.dart' as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AppRouter>(() => _i3.AppRouter());
  gh.lazySingleton<_i4.LocalStorageService>(() => _i4.LocalStorageService());
  gh.lazySingleton<_i5.RecipeScheduleLocalDataSourceImpl>(
      () => _i5.RecipeScheduleLocalDataSourceImpl());
  gh.lazySingleton<_i6.Kubo>(() => _i6.Kubo(
      appRouter: get<_i3.AppRouter>(),
      localStorageService: get<_i4.LocalStorageService>()));
  return get;
}
