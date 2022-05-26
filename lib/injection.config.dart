// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i4;
import 'package:http/http.dart' as _i10;
import 'package:injectable/injectable.dart' as _i2;

import 'core/helpers/date_converter.dart' as _i11;
import 'core/hive/box_module.dart' as _i59;
import 'core/hive/remote_module.dart' as _i60;
import 'features/food_planner/data/datasources/recipe_local_data_source.dart'
    as _i13;
import 'features/food_planner/data/datasources/recipe_schedule_local_data_source.dart'
    as _i14;
import 'features/food_planner/data/datasources/recipes_remote_data_source.dart'
    as _i17;
import 'features/food_planner/data/datasources/reminder_remote_data_source.dart'
    as _i18;
import 'features/food_planner/data/datasources/user_local_data_source.dart'
    as _i25;
import 'features/food_planner/data/repositories/recipe_repository_impl.dart'
    as _i46;
import 'features/food_planner/data/repositories/recipe_schedule_repository_impl.dart'
    as _i16;
import 'features/food_planner/data/repositories/reminder_repository_impl.dart'
    as _i20;
import 'features/food_planner/data/repositories/user_repository_impl.dart'
    as _i27;
import 'features/food_planner/domain/entities/recipe.dart' as _i6;
import 'features/food_planner/domain/entities/recipe_schedule.dart' as _i5;
import 'features/food_planner/domain/entities/user.dart' as _i7;
import 'features/food_planner/domain/repositories/recipe_repository.dart'
    as _i45;
import 'features/food_planner/domain/repositories/recipe_schedule_repository.dart'
    as _i15;
import 'features/food_planner/domain/repositories/reminder_repository.dart'
    as _i19;
import 'features/food_planner/domain/repositories/user_repository.dart' as _i26;
import 'features/food_planner/domain/usecases/create_cache_recipe.dart' as _i52;
import 'features/food_planner/domain/usecases/create_recipe_schedule.dart'
    as _i30;
import 'features/food_planner/domain/usecases/fetch_cached_recipes.dart'
    as _i53;
import 'features/food_planner/domain/usecases/fetch_filtered_recipes.dart'
    as _i54;
import 'features/food_planner/domain/usecases/fetch_recipe.dart' as _i55;
import 'features/food_planner/domain/usecases/fetch_recipe_schedule_linked_hash_map.dart'
    as _i35;
import 'features/food_planner/domain/usecases/fetch_recipe_schedules.dart'
    as _i36;
import 'features/food_planner/domain/usecases/fetch_recipes.dart' as _i56;
import 'features/food_planner/domain/usecases/fetch_reminders.dart' as _i37;
import 'features/food_planner/domain/usecases/fetch_user.dart' as _i38;
import 'features/food_planner/domain/usecases/initialize_user.dart' as _i39;
import 'features/food_planner/presentation/blocs/menu/menu_bloc.dart' as _i57;
import 'features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart'
    as _i40;
import 'features/food_planner/presentation/blocs/recipe/recipe_bloc.dart'
    as _i58;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart'
    as _i43;
import 'features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart'
    as _i44;
import 'features/food_planner/presentation/blocs/recipe_selection_dialog/recipe_selection_dialog_bloc.dart'
    as _i47;
import 'features/food_planner/presentation/blocs/reminder/reminder_bloc.dart'
    as _i48;
import 'features/food_planner/presentation/blocs/user/user_bloc.dart' as _i51;
import 'features/smart_recipe_selection/data/datasources/smart_recipe_selection_local_data_source.dart'
    as _i21;
import 'features/smart_recipe_selection/data/datasources/smart_recipe_selection_remote_data_source.dart'
    as _i22;
import 'features/smart_recipe_selection/data/repositories/smart_recipe_selection_repository_impl.dart'
    as _i24;
import 'features/smart_recipe_selection/domain/entities/category.dart' as _i8;
import 'features/smart_recipe_selection/domain/entities/predicted_image.dart'
    as _i9;
import 'features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart'
    as _i23;
import 'features/smart_recipe_selection/domain/usecases/create_category.dart'
    as _i28;
import 'features/smart_recipe_selection/domain/usecases/create_predicted_image.dart'
    as _i29;
import 'features/smart_recipe_selection/domain/usecases/delete_expired_predicted_images.dart'
    as _i31;
import 'features/smart_recipe_selection/domain/usecases/delete_predicted_images.dart'
    as _i32;
import 'features/smart_recipe_selection/domain/usecases/fetch_categories.dart'
    as _i33;
import 'features/smart_recipe_selection/domain/usecases/fetch_predicted_images.dart'
    as _i34;
import 'features/smart_recipe_selection/domain/usecases/predict_image.dart'
    as _i41;
import 'features/smart_recipe_selection/presentation/blocs/captured_page/save_scanned_ingredients_bloc.dart'
    as _i49;
import 'features/smart_recipe_selection/presentation/blocs/predict_image/predict_image_bloc.dart'
    as _i42;
import 'features/smart_recipe_selection/presentation/blocs/scanned_pictures_list/scanned_pictures_list_bloc.dart'
    as _i50;
import 'main.dart' as _i12;
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
  await gh.factoryAsync<_i4.Box<_i9.PredictedImage>>(
      () => boxModule.predictedImage,
      preResolve: true);
  gh.factory<_i10.Client>(() => remoteModule.prefs);
  gh.lazySingleton<_i11.DateConverter>(() => _i11.DateConverter());
  gh.lazySingleton<_i12.Kubo>(() => _i12.Kubo(appRouter: get<_i3.AppRouter>()));
  gh.lazySingleton<_i13.RecipeLocalDataSource>(() =>
      _i13.RecipeLocalDataSourceImpl(recipeBox: get<_i4.Box<_i6.Recipe>>()));
  gh.lazySingleton<_i14.RecipeScheduleLocalDataSource>(() =>
      _i14.RecipeScheduleLocalDataSourceImpl(
          recipeScheduleBox: get<_i4.Box<_i5.RecipeSchedule>>()));
  gh.lazySingleton<_i15.RecipeScheduleRepository>(() =>
      _i16.RecipeScheduleRepositoryImpl(
          recipeLocalDataSource: get<_i14.RecipeScheduleLocalDataSource>()));
  gh.lazySingleton<_i17.RecipesRemoteDataSource>(
      () => _i17.RecipesRemoteDataSourceImpl(client: get<_i10.Client>()));
  gh.lazySingleton<_i18.ReminderRemoteDataSource>(
      () => _i18.ReminderRemoteDataSourceImpl(client: get<_i10.Client>()));
  gh.lazySingleton<_i19.ReminderRepository>(
      () => _i20.ReminderRepositoryImpl(get<_i18.ReminderRemoteDataSource>()));
  gh.lazySingleton<_i21.SmartRecipeSelectionLocalDataSource>(() =>
      _i21.SmartRecipeSelectionLocalDataSourceImpl(
          categoryBox: get<_i4.Box<_i8.Category>>(),
          predictedImageBox: get<_i4.Box<_i9.PredictedImage>>()));
  gh.lazySingleton<_i22.SmartRecipeSelectionRemoteDataSource>(
      () => _i22.SmartRecipeSelectionRemoteDataSourceImpl());
  gh.lazySingleton<_i23.SmartRecipeSelectionRepository>(() =>
      _i24.SmartRecipeSelectionRepositoryImpl(
          smartRecipeSelectionRemoteDataSource:
              get<_i22.SmartRecipeSelectionRemoteDataSource>(),
          smartRecipeSelectionLocalDataSource:
              get<_i21.SmartRecipeSelectionLocalDataSource>()));
  gh.lazySingleton<_i25.UserLocalDataSource>(
      () => _i25.UserLocalDataSourceImpl(userBox: get<_i4.Box<_i7.User>>()));
  gh.lazySingleton<_i26.UserRepository>(
      () => _i27.UserRepositoryImpl(get<_i25.UserLocalDataSource>()));
  gh.lazySingleton<_i28.CreateCategory>(
      () => _i28.CreateCategory(get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i29.CreatePredictedImage>(() =>
      _i29.CreatePredictedImage(get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i30.CreateRecipeSchedule>(
      () => _i30.CreateRecipeSchedule(get<_i15.RecipeScheduleRepository>()));
  gh.lazySingleton<_i31.DeleteExpiredPredictedImages>(() =>
      _i31.DeleteExpiredPredictedImages(
          get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i32.DeletePredictedImages>(() =>
      _i32.DeletePredictedImages(get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i33.FetchCategories>(
      () => _i33.FetchCategories(get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i34.FetchPredictedImages>(() =>
      _i34.FetchPredictedImages(get<_i23.SmartRecipeSelectionRepository>()));
  gh.lazySingleton<_i35.FetchRecipeScheduleLinkedHashMap>(() =>
      _i35.FetchRecipeScheduleLinkedHashMap(
          get<_i15.RecipeScheduleRepository>()));
  gh.lazySingleton<_i36.FetchRecipeSchedules>(
      () => _i36.FetchRecipeSchedules(get<_i15.RecipeScheduleRepository>()));
  gh.lazySingleton<_i37.FetchReminders>(
      () => _i37.FetchReminders(get<_i19.ReminderRepository>()));
  gh.lazySingleton<_i38.FetchUser>(
      () => _i38.FetchUser(get<_i26.UserRepository>()));
  gh.lazySingleton<_i39.InitializeUser>(
      () => _i39.InitializeUser(get<_i26.UserRepository>()));
  gh.factory<_i40.MenuHistoryBloc>(() => _i40.MenuHistoryBloc(
      fetchRecipeScheduleLinkedHashMap:
          get<_i35.FetchRecipeScheduleLinkedHashMap>()));
  gh.lazySingleton<_i41.PredictImage>(
      () => _i41.PredictImage(get<_i23.SmartRecipeSelectionRepository>()));
  gh.factory<_i42.PredictImageBloc>(
      () => _i42.PredictImageBloc(predictImage: get<_i41.PredictImage>()));
  gh.factory<_i43.RecipeInfoCreateRecipeScheduleBloc>(() =>
      _i43.RecipeInfoCreateRecipeScheduleBloc(
          createRecipeSchedule: get<_i30.CreateRecipeSchedule>(),
          dateConverter: get<_i11.DateConverter>()));
  gh.factory<_i44.RecipeInfoFetchRecipeSchedulesBloc>(() =>
      _i44.RecipeInfoFetchRecipeSchedulesBloc(
          fetchRecipeSchedules: get<_i36.FetchRecipeSchedules>()));
  gh.lazySingleton<_i45.RecipeRepository>(() => _i46.RecipeRepositoryImpl(
      get<_i17.RecipesRemoteDataSource>(), get<_i13.RecipeLocalDataSource>()));
  gh.factory<_i47.RecipeSelectionDialogBloc>(() =>
      _i47.RecipeSelectionDialogBloc(
          fetchCategories: get<_i33.FetchCategories>()));
  gh.factory<_i48.ReminderBloc>(
      () => _i48.ReminderBloc(fetchReminders: get<_i37.FetchReminders>()));
  gh.factory<_i49.SaveScannedIngredientsBloc>(() =>
      _i49.SaveScannedIngredientsBloc(
          createPredictedImage: get<_i29.CreatePredictedImage>(),
          createCategory: get<_i28.CreateCategory>()));
  gh.factory<_i50.ScannedPicturesListBloc>(() => _i50.ScannedPicturesListBloc(
      fetchPredictedImages: get<_i34.FetchPredictedImages>(),
      deleteExpiredPredictedImages: get<_i31.DeleteExpiredPredictedImages>(),
      deletePredictedImages: get<_i32.DeletePredictedImages>()));
  gh.factory<_i51.UserBloc>(() => _i51.UserBloc(
      fetchUser: get<_i38.FetchUser>(),
      initializeUser: get<_i39.InitializeUser>()));
  gh.lazySingleton<_i52.CreateCacheRecipe>(
      () => _i52.CreateCacheRecipe(get<_i45.RecipeRepository>()));
  gh.lazySingleton<_i53.FetchCachedRecipes>(
      () => _i53.FetchCachedRecipes(get<_i45.RecipeRepository>()));
  gh.lazySingleton<_i54.FetchFilteredRecipes>(
      () => _i54.FetchFilteredRecipes(get<_i45.RecipeRepository>()));
  gh.lazySingleton<_i55.FetchRecipe>(
      () => _i55.FetchRecipe(get<_i45.RecipeRepository>()));
  gh.lazySingleton<_i56.FetchRecipes>(
      () => _i56.FetchRecipes(get<_i45.RecipeRepository>()));
  gh.factory<_i57.MenuBloc>(() => _i57.MenuBloc(
      fetchRecipeSchedules: get<_i36.FetchRecipeSchedules>(),
      fetchRecipe: get<_i55.FetchRecipe>()));
  gh.factory<_i58.RecipeBloc>(() => _i58.RecipeBloc(
      fetchRecipes: get<_i56.FetchRecipes>(),
      fetchFilteredRecipes: get<_i54.FetchFilteredRecipes>(),
      createCacheRecipe: get<_i52.CreateCacheRecipe>(),
      fetchCachedRecipes: get<_i53.FetchCachedRecipes>()));
  return get;
}

class _$BoxModule extends _i59.BoxModule {}

class _$RemoteModule extends _i60.RemoteModule {}
