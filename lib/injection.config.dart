// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i4;
import 'package:http/http.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;

import 'core/helpers/date_converter.dart' as _i10;
import 'core/hive/box_module.dart' as _i50;
import 'core/hive/remote_module.dart' as _i51;
import 'features/food_planner/data/datasources/recipe_local_data_source.dart'
    as _i12;
import 'features/food_planner/data/datasources/recipe_schedule_local_data_source.dart'
    as _i13;
import 'features/food_planner/data/datasources/recipes_remote_data_source.dart'
    as _i16;
import 'features/food_planner/data/datasources/reminder_remote_data_source.dart'
    as _i17;
import 'features/food_planner/data/datasources/user_local_data_source.dart'
    as _i24;
import 'features/food_planner/data/repositories/recipe_repository_impl.dart'
    as _i40;
import 'features/food_planner/data/repositories/recipe_schedule_repository_impl.dart'
    as _i15;
import 'features/food_planner/data/repositories/reminder_repository_impl.dart'
    as _i19;
import 'features/food_planner/data/repositories/user_repository_impl.dart'
    as _i26;
import 'features/food_planner/domain/entities/recipe.dart' as _i6;
import 'features/food_planner/domain/entities/recipe_schedule.dart' as _i5;
import 'features/food_planner/domain/entities/user.dart' as _i7;
import 'features/food_planner/domain/repositories/recipe_repository.dart'
    as _i39;
import 'features/food_planner/domain/repositories/recipe_schedule_repository.dart'
    as _i14;
import 'features/food_planner/domain/repositories/reminder_repository.dart'
    as _i18;
import 'features/food_planner/domain/repositories/user_repository.dart' as _i25;
import 'features/food_planner/domain/usecases/create_cache_recipe.dart' as _i43;
import 'features/food_planner/domain/usecases/create_recipe_schedule.dart'
    as _i28;
import 'features/food_planner/domain/usecases/fetch_cached_recipes.dart'
    as _i44;
import 'features/food_planner/domain/usecases/fetch_filtered_recipes.dart'
    as _i45;
import 'features/food_planner/domain/usecases/fetch_recipe.dart' as _i46;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart'
    as _i29;
import 'features/food_planner/domain/usecases/fetch_recipe_schedules.dart'
    as _i30;
import 'features/food_planner/domain/usecases/fetch_recipes.dart' as _i47;
import 'features/food_planner/domain/usecases/fetch_reminders.dart' as _i31;
import 'features/food_planner/domain/usecases/fetch_user.dart' as _i32;
import 'features/food_planner/domain/usecases/initialize_user.dart' as _i33;
import 'features/food_planner/presentation/blocs/menu/menu_bloc.dart' as _i48;
import 'features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart'
    as _i34;
import 'features/food_planner/presentation/blocs/recipe/recipe_bloc.dart'
    as _i49;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart'
    as _i37;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart'
    as _i38;
import 'features/food_planner/presentation/blocs/reminder/reminder_bloc.dart'
    as _i41;
import 'features/food_planner/presentation/blocs/user/user_bloc.dart' as _i42;
import 'features/smart_recipe_selection/data/datasources/smart_recipe_selection_remote_data_source.dart'
    as _i21;
import 'features/smart_recipe_selection/data/datasources/snart_recipe_selection_local_data_source.dart'
    as _i20;
import 'features/smart_recipe_selection/data/repositories/smart_recipe_selection_repository_impl.dart'
    as _i23;
import 'features/smart_recipe_selection/domain/entities/category.dart' as _i8;
import 'features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart'
    as _i22;
import 'features/smart_recipe_selection/domain/usecases/create_category.dart'
    as _i27;
import 'features/smart_recipe_selection/domain/usecases/predict_image.dart'
    as _i35;
import 'features/smart_recipe_selection/presentation/blocs/predict_image/predict_image_bloc.dart'
    as _i36;
import 'main.dart' as _i11;
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
  await gh.factoryAsync<_i4.Box<_i8.Category>>(() => boxModule.category,
      preResolve: true);
  gh.factory<_i9.Client>(() => remoteModule.prefs);
  gh.lazySingleton<_i10.DateConverter>(() => _i10.DateConverter());
  gh.lazySingleton<_i11.Kubo>(() => _i11.Kubo(appRouter: get<_i3.AppRouter>()));
  gh.lazySingleton<_i12.RecipeLocalDataSource>(() =>
      _i12.RecipeLocalDataSourceImpl(recipeBox: get<_i4.Box<_i6.Recipe>>()));
  gh.lazySingleton<_i13.RecipeScheduleLocalDataSource>(() =>
      _i13.RecipeScheduleLocalDataSourceImpl(
          recipeScheduleBox: get<_i4.Box<_i5.RecipeSchedule>>()));
  gh.lazySingleton<_i14.RecipeScheduleRepository>(() =>
      _i15.RecipeScheduleRepositoryImpl(
          recipeLocalDataSource: get<_i13.RecipeScheduleLocalDataSource>()));
  gh.lazySingleton<_i16.RecipesRemoteDataSource>(
      () => _i16.RecipesRemoteDataSourceImpl(client: get<_i9.Client>()));
  gh.lazySingleton<_i17.ReminderRemoteDataSource>(
      () => _i17.ReminderRemoteDataSourceImpl(client: get<_i9.Client>()));
  gh.lazySingleton<_i18.ReminderRepository>(
      () => _i19.ReminderRepositoryImpl(get<_i17.ReminderRemoteDataSource>()));
  gh.lazySingleton<_i20.SmartRecipeSelectionLocalDataSource>(() =>
      _i20.SmartRecipeSelectionLocalDataSourceImpl(
          categoryBox: get<_i4.Box<_i8.Category>>()));
  gh.lazySingleton<_i21.SmartRecipeSelectionRemoteDataSource>(
      () => _i21.SmartRecipeSelectionRemoteDataSourceImpl());
  gh.lazySingleton<_i22.SmartRecipeSelectionRepository>(() =>
      _i23.SmartRecipeSelectionRepositoryImpl(
          smartRecipeSelectionRemoteDataSource:
              get<_i21.SmartRecipeSelectionRemoteDataSource>(),
          smartRecipeSelectionLocalDataSource:
              get<_i20.SmartRecipeSelectionLocalDataSource>()));
  gh.lazySingleton<_i24.UserLocalDataSource>(
      () => _i24.UserLocalDataSourceImpl(userBox: get<_i4.Box<_i7.User>>()));
  gh.lazySingleton<_i25.UserRepository>(
      () => _i26.UserRepositoryImpl(get<_i24.UserLocalDataSource>()));
  gh.lazySingleton<_i27.CreateCategory>(
      () => _i27.CreateCategory(get<_i22.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i28.CreateRecipeSchedule>(
      () => _i28.CreateRecipeSchedule(get<_i14.RecipeScheduleRepository>()));
  gh.lazySingleton<_i29.FetchRecipeScheduleLinkedHashMap>(() =>
      _i29.FetchRecipeScheduleLinkedHashMap(
          get<_i14.RecipeScheduleRepository>()));
  gh.lazySingleton<_i30.FetchRecipeSchedules>(
      () => _i30.FetchRecipeSchedules(get<_i14.RecipeScheduleRepository>()));
  gh.lazySingleton<_i31.FetchReminders>(
      () => _i31.FetchReminders(get<_i18.ReminderRepository>()));
  gh.lazySingleton<_i32.FetchUser>(
      () => _i32.FetchUser(get<_i25.UserRepository>()));
  gh.lazySingleton<_i33.InitializeUser>(
      () => _i33.InitializeUser(get<_i25.UserRepository>()));
  gh.factory<_i34.MenuHistoryBloc>(() => _i34.MenuHistoryBloc(
      fetchRecipeScheduleLinkedHashMap:
          get<_i29.FetchRecipeScheduleLinkedHashMap>()));
  gh.lazySingleton<_i35.PredictImage>(
      () => _i35.PredictImage(get<_i22.SmartRecipeSelectionRepository>()));
  gh.factory<_i36.PredictImageBloc>(
      () => _i36.PredictImageBloc(predictImage: get<_i35.PredictImage>()));
  gh.factory<_i37.RecipeInfoCreateRecipeScheduleBloc>(() =>
      _i37.RecipeInfoCreateRecipeScheduleBloc(
          createRecipeSchedule: get<_i28.CreateRecipeSchedule>(),
          dateConverter: get<_i10.DateConverter>()));
  gh.factory<_i38.RecipeInfoFetchRecipeSchedulesBloc>(() =>
      _i38.RecipeInfoFetchRecipeSchedulesBloc(
          fetchRecipeSchedules: get<_i30.FetchRecipeSchedules>()));
  gh.lazySingleton<_i39.RecipeRepository>(() => _i40.RecipeRepositoryImpl(
      get<_i16.RecipesRemoteDataSource>(), get<_i12.RecipeLocalDataSource>()));
  gh.factory<_i41.ReminderBloc>(
      () => _i41.ReminderBloc(fetchReminders: get<_i31.FetchReminders>()));
  gh.factory<_i42.UserBloc>(() => _i42.UserBloc(
      fetchUser: get<_i32.FetchUser>(),
      initializeUser: get<_i33.InitializeUser>()));
  gh.lazySingleton<_i43.CreateCacheRecipe>(
      () => _i43.CreateCacheRecipe(get<_i39.RecipeRepository>()));
  gh.lazySingleton<_i44.FetchCachedRecipes>(
      () => _i44.FetchCachedRecipes(get<_i39.RecipeRepository>()));
  gh.lazySingleton<_i45.FetchFilteredRecipes>(
      () => _i45.FetchFilteredRecipes(get<_i39.RecipeRepository>()));
  gh.lazySingleton<_i46.FetchRecipe>(
      () => _i46.FetchRecipe(get<_i39.RecipeRepository>()));
  gh.lazySingleton<_i47.FetchRecipes>(
      () => _i47.FetchRecipes(get<_i39.RecipeRepository>()));
  gh.factory<_i48.MenuBloc>(() => _i48.MenuBloc(
      fetchRecipeSchedules: get<_i30.FetchRecipeSchedules>(),
      fetchRecipe: get<_i46.FetchRecipe>()));
  gh.factory<_i49.RecipeBloc>(() => _i49.RecipeBloc(
      fetchRecipes: get<_i47.FetchRecipes>(),
      fetchFilteredRecipes: get<_i45.FetchFilteredRecipes>(),
      createCacheRecipe: get<_i43.CreateCacheRecipe>(),
      fetchCachedRecipes: get<_i44.FetchCachedRecipes>()));
  return get;
}

class _$BoxModule extends _i50.BoxModule {}

class _$RemoteModule extends _i51.RemoteModule {}
