import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';

class KuboAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KuboAppBar(this.title,{ Key? key }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: kBackgroundGrey,
          automaticallyImplyLeading: false,
          elevation: 0,
          title:  Text(
            title,
            style: const TextStyle(
              color: kBlackPrimary,
              fontFamily: 'Pushster',
              fontSize: 30.0,
            ),
          ),
        );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(45.0);
}