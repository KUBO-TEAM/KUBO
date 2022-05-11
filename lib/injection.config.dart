// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i4;
import 'package:http/http.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;

import 'core/helpers/date_converter.dart' as _i9;
import 'core/hive/box_module.dart' as _i47;
import 'core/hive/remote_module.dart' as _i48;
import 'features/food_planner/data/datasources/recipe_local_data_source.dart'
    as _i11;
import 'features/food_planner/data/datasources/recipe_schedule_local_data_source.dart'
    as _i12;
import 'features/food_planner/data/datasources/recipes_remote_data_source.dart'
    as _i15;
import 'features/food_planner/data/datasources/reminder_remote_data_source.dart'
    as _i16;
import 'features/food_planner/data/datasources/user_local_data_source.dart'
    as _i22;
import 'features/food_planner/data/repositories/recipe_repository_impl.dart'
    as _i37;
import 'features/food_planner/data/repositories/recipe_schedule_repository_impl.dart'
    as _i14;
import 'features/food_planner/data/repositories/reminder_repository_impl.dart'
    as _i18;
import 'features/food_planner/data/repositories/user_repository_impl.dart'
    as _i24;
import 'features/food_planner/domain/entities/recipe.dart' as _i6;
import 'features/food_planner/domain/entities/recipe_schedule.dart' as _i5;
import 'features/food_planner/domain/entities/user.dart' as _i7;
import 'features/food_planner/domain/repositories/recipe_repository.dart'
    as _i36;
import 'features/food_planner/domain/repositories/recipe_schedule_repository.dart'
    as _i13;
import 'features/food_planner/domain/repositories/reminder_repository.dart'
    as _i17;
import 'features/food_planner/domain/repositories/user_repository.dart' as _i23;
import 'features/food_planner/domain/usecases/create_cache_recipe.dart' as _i40;
import 'features/food_planner/domain/usecases/create_recipe_schedule.dart'
    as _i25;
import 'features/food_planner/domain/usecases/fetch_cached_recipes.dart'
    as _i41;
import 'features/food_planner/domain/usecases/fetch_filtered_recipes.dart'
    as _i42;
import 'features/food_planner/domain/usecases/fetch_recipe.dart' as _i43;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart'
    as _i26;
import 'features/food_planner/domain/usecases/fetch_recipe_schedules.dart'
    as _i27;
import 'features/food_planner/domain/usecases/fetch_recipes.dart' as _i44;
import 'features/food_planner/domain/usecases/fetch_reminders.dart' as _i28;
import 'features/food_planner/domain/usecases/fetch_user.dart' as _i29;
import 'features/food_planner/domain/usecases/initialize_user.dart' as _i30;
import 'features/food_planner/presentation/blocs/bloc/user_bloc.dart' as _i39;
import 'features/food_planner/presentation/blocs/menu/menu_bloc.dart' as _i45;
import 'features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart'
    as _i31;
import 'features/food_planner/presentation/blocs/recipe/recipe_bloc.dart'
    as _i46;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart'
    as _i34;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart'
    as _i35;
import 'features/food_planner/presentation/blocs/reminder/reminder_bloc.dart'
    as _i38;
import 'features/smart_recipe_selection/data/datasources/smart_recipe_selection_remote_data_source.dart'
    as _i19;
import 'features/smart_recipe_selection/data/repositories/smart_recipe_selection_repository_impl.dart'
    as _i21;
import 'features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart'
    as _i20;
import 'features/smart_recipe_selection/domain/usecases/predict_image.dart'
    as _i32;
import 'features/smart_recipe_selection/presentation/blocs/predict_image/predict_image_bloc.dart'
    as _i33;
import 'main.dart' as _i10;
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
  gh.factory<_i8.Client>(() => remoteModule.prefs);
  gh.lazySingleton<_i9.DateConverter>(() => _i9.DateConverter());
  gh.lazySingleton<_i10.Kubo>(() => _i10.Kubo(appRouter: get<_i3.AppRouter>()));
  gh.lazySingleton<_i11.RecipeLocalDataSource>(() =>
      _i11.RecipeLocalDataSourceImpl(recipeBox: get<_i4.Box<_i6.Recipe>>()));
  gh.lazySingleton<_i12.RecipeScheduleLocalDataSource>(() =>
      _i12.RecipeScheduleLocalDataSourceImpl(
          recipeScheduleBox: get<_i4.Box<_i5.RecipeSchedule>>()));
  gh.lazySingleton<_i13.RecipeScheduleRepository>(() =>
      _i14.RecipeScheduleRepositoryImpl(
          recipeLocalDataSource: get<_i12.RecipeScheduleLocalDataSource>()));
  gh.lazySingleton<_i15.RecipesRemoteDataSource>(
      () => _i15.RecipesRemoteDataSourceImpl(client: get<_i8.Client>()));
  gh.lazySingleton<_i16.ReminderRemoteDataSource>(
      () => _i16.ReminderRemoteDataSourceImpl(client: get<_i8.Client>()));
  gh.lazySingleton<_i17.ReminderRepository>(
      () => _i18.ReminderRepositoryImpl(get<_i16.ReminderRemoteDataSource>()));
  gh.lazySingleton<_i19.SmartRecipeSelectionRemoteDataSource>(
      () => _i19.SmartRecipeSelectionRemoteDataSourceImpl());
  gh.lazySingleton<_i20.SmartRecipeSelectionRepository>(() =>
      _i21.SmartRecipeSelectionRepositoryImpl(
          get<_i19.SmartRecipeSelectionRemoteDataSource>()));
  gh.lazySingleton<_i22.UserLocalDataSource>(
      () => _i22.UserLocalDataSourceImpl(userBox: get<_i4.Box<_i7.User>>()));
  gh.lazySingleton<_i23.UserRepository>(
      () => _i24.UserRepositoryImpl(get<_i22.UserLocalDataSource>()));
  gh.lazySingleton<_i25.CreateRecipeSchedule>(
      () => _i25.CreateRecipeSchedule(get<_i13.RecipeScheduleRepository>()));
  gh.lazySingleton<_i26.FetchRecipeScheduleLinkedHashMap>(() =>
      _i26.FetchRecipeScheduleLinkedHashMap(
          get<_i13.RecipeScheduleRepository>()));
  gh.lazySingleton<_i27.FetchRecipeSchedules>(
      () => _i27.FetchRecipeSchedules(get<_i13.RecipeScheduleRepository>()));
  gh.lazySingleton<_i28.FetchReminders>(
      () => _i28.FetchReminders(get<_i17.ReminderRepository>()));
  gh.lazySingleton<_i29.FetchUser>(
      () => _i29.FetchUser(get<_i23.UserRepository>()));
  gh.lazySingleton<_i30.InitializeUser>(
      () => _i30.InitializeUser(get<_i23.UserRepository>()));
  gh.factory<_i31.MenuHistoryBloc>(() => _i31.MenuHistoryBloc(
      fetchRecipeScheduleLinkedHashMap:
          get<_i26.FetchRecipeScheduleLinkedHashMap>()));
  gh.lazySingleton<_i32.PredictImage>(
      () => _i32.PredictImage(get<_i20.SmartRecipeSelectionRepository>()));
  gh.factory<_i33.PredictImageBloc>(
      () => _i33.PredictImageBloc(predictImage: get<_i32.PredictImage>()));
  gh.factory<_i34.RecipeInfoCreateRecipeScheduleBloc>(() =>
      _i34.RecipeInfoCreateRecipeScheduleBloc(
          createRecipeSchedule: get<_i25.CreateRecipeSchedule>(),
          dateConverter: get<_i9.DateConverter>()));
  gh.factory<_i35.RecipeInfoFetchRecipeSchedulesBloc>(() =>
      _i35.RecipeInfoFetchRecipeSchedulesBloc(
          fetchRecipeSchedules: get<_i27.FetchRecipeSchedules>()));
  gh.lazySingleton<_i36.RecipeRepository>(() => _i37.RecipeRepositoryImpl(
      get<_i15.RecipesRemoteDataSource>(), get<_i11.RecipeLocalDataSource>()));
  gh.factory<_i38.ReminderBloc>(
      () => _i38.ReminderBloc(fetchReminders: get<_i28.FetchReminders>()));
  gh.factory<_i39.UserBloc>(() => _i39.UserBloc(
      fetchUser: get<_i29.FetchUser>(),
      initializeUser: get<_i30.InitializeUser>()));
  gh.lazySingleton<_i40.CreateCacheRecipe>(
      () => _i40.CreateCacheRecipe(get<_i36.RecipeRepository>()));
  gh.lazySingleton<_i41.FetchCachedRecipes>(
      () => _i41.FetchCachedRecipes(get<_i36.RecipeRepository>()));
  gh.lazySingleton<_i42.FetchFilteredRecipes>(
      () => _i42.FetchFilteredRecipes(get<_i36.RecipeRepository>()));
  gh.lazySingleton<_i43.FetchRecipe>(
      () => _i43.FetchRecipe(get<_i36.RecipeRepository>()));
  gh.lazySingleton<_i44.FetchRecipes>(
      () => _i44.FetchRecipes(get<_i36.RecipeRepository>()));
  gh.factory<_i45.MenuBloc>(() => _i45.MenuBloc(
      fetchRecipeSchedules: get<_i27.FetchRecipeSchedules>(),
      fetchRecipe: get<_i43.FetchRecipe>()));
  gh.factory<_i46.RecipeBloc>(() => _i46.RecipeBloc(
      fetchRecipes: get<_i44.FetchRecipes>(),
      fetchFilteredRecipes: get<_i42.FetchFilteredRecipes>(),
      createCacheRecipe: get<_i40.CreateCacheRecipe>(),
      fetchCachedRecipes: get<_i41.FetchCachedRecipes>()));
  return get;
}

class _$BoxModule extends _i47.BoxModule {}

class _$RemoteModule extends _i48.RemoteModule {}
