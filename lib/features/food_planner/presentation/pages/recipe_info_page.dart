import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/info_tab.dart';
import 'package:kubo/features/food_planner/presentation/widgets/procedure_tab.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_clipper.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_info_page_preview_info.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_info_tabbar.dart';
import 'package:kubo/features/food_planner/presentation/widgets/schedule_tab.dart';
import 'package:kubo/features/food_planner/presentation/widgets/screen_dark_effect.dart';

class RecipeInfoPage extends StatefulWidget {
  static const String id = 'recipe_steps_page';
  const RecipeInfoPage({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

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
    _tabController = TabController(length: 3, vsync: this);
    BlocProvider.of<RecipeInfoFetchRecipeSchedulesBloc>(context).add(
      RecipeInfoFetchRecipeSchedulesFetched(recipeId: widget.recipe.id),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Hero(
        tag: "recipe-img-${widget.recipe.displayPhoto}",
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: widget.recipe.displayPhoto,
              width: double.infinity,
              fit: BoxFit.fill,
              alignment: Alignment.center,
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
                                              widget.recipe.name,
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
                                      recipe: widget.recipe,
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
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    InfoTab(recipe: widget.recipe),
                    ProcedureTab(recipe: widget.recipe),
                    ScheduleTab(recipe: widget.recipe),
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
