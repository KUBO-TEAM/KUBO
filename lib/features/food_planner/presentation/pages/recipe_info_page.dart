import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/info_tab.dart';
import 'package:kubo/features/food_planner/presentation/widgets/procedure_tab.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_clipper.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_info_page_preview_info.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_info_tabbar.dart';
import 'package:kubo/features/food_planner/presentation/widgets/schedule_tab.dart';
import 'package:kubo/features/food_planner/presentation/widgets/screen_dark_effect.dart';

class RecipeInfoPageArguments {
  final Recipe recipe;

  RecipeInfoPageArguments({
    required this.recipe,
  });
}

class RecipeInfoPage extends StatefulWidget {
  static const String id = 'recipe_steps_page';
  const RecipeInfoPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final RecipeInfoPageArguments arguments;

  @override
  _RecipeInfoPageState createState() => _RecipeInfoPageState();
}

class _RecipeInfoPageState extends State<RecipeInfoPage>
    with TickerProviderStateMixin {
  final List<String> recipeInfoTab = ['Info', 'Procedure', 'Schedule'];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    final createRecipeDialogState =
        BlocProvider.of<CreateRecipeScheduleDialogBloc>(context).state;

    int initialTabIndex = 0;

    if (createRecipeDialogState is CreateRecipeScheduleDialogSuccess) {
      initialTabIndex = 2;
    }

    _tabController = TabController(
      initialIndex: initialTabIndex,
      length: 3,
      vsync: this,
    );

    BlocProvider.of<RecipeInfoFetchRecipeSchedulesBloc>(context).add(
      RecipeInfoFetchRecipeSchedulesFetched(
        recipeId: widget.arguments.recipe.id,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final player = YoutubePlayer(
    //   controller: _youtubeController,
    //   aspectRatio: 16 / 9,
    // );
    return Scaffold(
      body: Hero(
        tag: "recipe-img-${widget.arguments.recipe.displayPhoto}",
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: widget.arguments.recipe.displayPhoto,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) {
                // if (downloadProgress == null) return Container();
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      kBrownPrimary,
                    ),
                    value: downloadProgress.progress,
                  ),
                );
              },
            ),
            const ScreenDarkEffect(),
            NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                      width: double.infinity,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 10.0,
                                bottom: 15.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 8.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          padding: const EdgeInsets.only(
                                            bottom: 10.0,
                                          ),
                                          icon: const Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.white,
                                          ),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            child: Text(
                                              widget.arguments.recipe.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Pushster',
                                                fontSize: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Expanded(
                                    child: RecipeInfoPagePreviewInfo(
                                      recipe: widget.arguments.recipe,
                                    ),
                                  ),
                                  RecipeInfoTabBar(
                                    recipeInfoTab: recipeInfoTab,
                                    tabController: _tabController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const RecipeClipper(),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: Container(
                color: Colors.white,
                transform: Matrix4.translationValues(0.0, -1.0, 0.0),
                child: Column(
                  children: [
                    // player,

                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          InfoTab(
                            recipe: widget.arguments.recipe,
                          ),
                          ProcedureTab(recipe: widget.arguments.recipe),
                          ScheduleTab(
                            recipe: widget.arguments.recipe,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
