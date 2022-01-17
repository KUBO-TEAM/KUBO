import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/sizes.constants.dart';
import 'package:kubo/modules/menu_history/states/menu_history.states.dart';

class MenuHistoryScreen extends StatelessWidget {
  static const String id = 'calendar_screen';
  const MenuHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: kAppBarPrefferedSize,
        child: AppBar(
          backgroundColor: kBackgroundGrey,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: kBlackPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          title: const Text(
            'Calendar',
            style: TextStyle(
              color: kBlackPrimary,
              fontFamily: 'Pushster',
              fontSize: 30.0,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: const MenuHistory(),
          color: kBackgroundGrey,
        ),
      ),
    );
  }
}
