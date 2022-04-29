import 'package:cached_network_image/cached_network_image.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
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
  late ScrollController _scrollController;
  bool fixedScroll = false;
  bool showAppBar = true;
  Color appBarColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(length: 3, vsync: this);
    // _tabController.addListener(_smoothScrollToTop);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    /** Across infobar */
    if (_scrollController.offset >= 40 &&
        _scrollController.offset < 140 &&
        showAppBar != false) {
      setState(() {
        showAppBar = false;
      });
    } else if (_scrollController.offset >= 280 &&
        _scrollController.offset <= 330 &&
        showAppBar != false) {
      setState(() {
        showAppBar = false;
      });
    } else if (_scrollController.offset > 140 &&
        _scrollController.offset < 280 &&
        showAppBar != true) {
      setState(() {
        showAppBar = true;
      });
    } else if (_scrollController.offset < 40 && showAppBar != true) {
      setState(() {
        showAppBar = true;
      });
    }

    /** Inside main tab */
    // if (_scrollController.offset >= 350 && appBarColor != Colors.black) {
    //   setState(() {
    //     appBarColor = Colors.black;
    //   });
    // } else if (_scrollController.offset < 350 && appBarColor != Colors.white) {
    //   setState(() {
    //     appBarColor = Colors.white;
    //   });
    // }
    // if (fixedScroll) {
    //   _scrollController.jumpTo(0);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: showAppBar
          ? AppBar(
              backgroundColor: Colors.transparent,
              titleSpacing: 0,
              leading: IconButton(
                padding: const EdgeInsets.only(left: 20),
                icon: Icon(Icons.arrow_back_ios, color: appBarColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  widget.recipe.name,
                  style: TextStyle(
                    color: appBarColor,
                    fontFamily: 'Pushster',
                    fontSize: 30.0,
                  ),
                ),
              ),
            )
          : null,
      body: DirectSelectContainer(
        child: Hero(
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
                controller: _scrollController,
                headerSliverBuilder: (context, value) {
                  return [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 10.0,
                                bottom: 15.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RecipeInfoPagePreviewInfo(
                                    recipe: widget.recipe,
                                  ),
                                  RecipeInfoTabBar(
                                    recipeInfoTab: recipeInfoTab,
                                    tabController: _tabController,
                                  ),
                                ],
                              ),
                            ),
                            const RecipeClipper(),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    InfoTab(recipe: widget.recipe),
                    ProcedureTab(recipe: widget.recipe),
                    ScheduleTab(recipe: widget.recipe),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
