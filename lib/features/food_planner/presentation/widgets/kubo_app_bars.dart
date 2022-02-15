import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/appbar_clipper.dart';
import 'package:kubo/features/food_planner/presentation/widgets/icon_button.dart';

const _appBarSize = Size.fromHeight(45.0);

class KuboAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KuboAppBar(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundGrey,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: kBlackPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      title: Text(
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
  Size get preferredSize => _appBarSize;
}

class KuboHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KuboHomeAppBar(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundGrey,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: kBlackPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      title: Text(
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
  Size get preferredSize => _appBarSize;
}

class KuboTransparentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const KuboTransparentAppBar(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Pushster',
          fontSize: 30.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => _appBarSize;
}

class KuboClippedAppBar extends StatelessWidget {
  const KuboClippedAppBar(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        children: <Widget>[
          const AppbarClipper(color: kGreenPrimary),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CostumeIconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: kGreenPrimary,
                    size: 24.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Arvo Bold',
                  ),
                ),
                const Spacer(),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
