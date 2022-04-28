import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';

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
