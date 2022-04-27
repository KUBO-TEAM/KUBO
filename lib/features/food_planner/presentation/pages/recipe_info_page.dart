import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_clipper.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_info_page_background.dart';
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
  final List<String> recipeInfoTab = ['Ingredients', 'Steps', 'Schedule'];
  late TabController _tabController;
  late ScrollController _scrollController;
  bool fixedScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_smoothScrollToTop);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (fixedScroll) {
      _scrollController.jumpTo(0);
    }
  }

  _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );

    setState(() {
      fixedScroll = _tabController.index == 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: Text(
          widget.recipe.name,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Pushster',
            fontSize: 30.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          // RecipeInfoPageBackground(recipe: widget.recipe),
          CachedNetworkImage(
            imageUrl: widget.recipe.displayPhoto,
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
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, value) {
              return [
                // SliverPersistentHeader(
                //   delegate: _SliverPersistentHeaderDelegate(),
                //   pinned: true,
                // ),
                SliverToBoxAdapter(
                  child: Container(
                    child: RecipeInfoTabBar(
                      recipeInfoTab: recipeInfoTab,
                      tabController: _tabController,
                    ),
                    color: Colors.transparent,
                  ),
                ),
              ];
            },
            body: Stack(
              children: [
                TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Stack(
                        children: [
                          SizedBox(
                            child: RecipeClipper(),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .50,
                            ),
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              height: 4000,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .50 - 50,
                      ),
                      color: Colors.white,
                    ),
                    const Center(
                      child: Icon(
                        Icons.thumb_down,
                        color: Colors.grey,
                        size: 150,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     width: double.infinity,
      //     constraints: const BoxConstraints(
      //       minHeight: 270,
      //     ),
      //     child: Stack(
      //       children: [
      //         RecipeInfoPageBackground(recipe: widget.recipe),
      //         TabBarBackup(controller: _controller)
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

class RecipeInfoTabBar extends StatelessWidget {
  const RecipeInfoTabBar({
    Key? key,
    required TabController tabController,
    required this.recipeInfoTab,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final List<String> recipeInfoTab;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          height: 43,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.white54,
                width: 1,
              ),
              color: Colors.black.withOpacity(0.3)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 4,
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: kBrownPrimary,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 11,
              ),
              unselectedLabelColor: Colors.white70,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              tabs: recipeInfoTab.map((name) => Tab(text: name)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class TabBarBackup extends StatelessWidget {
  const TabBarBackup({
    Key? key,
    required TabController controller,
  })  : _controller = controller,
        super(key: key);

  final TabController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      height: 400,
      constraints: const BoxConstraints(
        minHeight: 270,
      ),
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 155,
      ),
      child: Column(
        children: [
          TabBarView(
            controller: _controller,
            children: [
              Container(
                color: Colors.red,
                child: const Text('test'),
              ),
              const Text("Steps"),
              const Center(
                child: Icon(
                  Icons.thumb_down,
                  color: Colors.grey,
                  size: 150,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

// class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       child: Placeholder(),
//     );
//   }

//   @override
//   double get maxExtent => 300;
//   @override
//   double get minExtent => 100;
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }
