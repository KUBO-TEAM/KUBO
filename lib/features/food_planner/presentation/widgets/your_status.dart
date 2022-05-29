import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/string_constants.dart';
import 'package:kubo/features/food_planner/presentation/blocs/your_status/your_status_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipes_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/icon_title.dart';
import 'package:kubo/features/food_planner/presentation/widgets/message_dialog.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/camera_page.dart';
import 'package:permission_handler/permission_handler.dart';

const _title = 'Your Status';
const _icon = Icons.person;

const _cardRadius = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  ),
);

class YourStatus extends StatefulWidget {
  const YourStatus({
    Key? key,
  }) : super(key: key);

  @override
  State<YourStatus> createState() => _YourStatusState();
}

class _YourStatusState extends State<YourStatus> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<YourStatusBloc>(context).add(YourStatusFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: _cardRadius,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        constraints: const BoxConstraints(
          minHeight: 150,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const IconTitle(
              icon: _icon,
              title: _title,
            ),
            const SizedBox(
              height: 10.0,
            ),
            BlocBuilder<YourStatusBloc, YourStatusState>(
              builder: (context, state) {
                if (state is YourStatusSuccess) {
                  final categoriesLength = state.categoriesLength;
                  final recipeSchedulesLength = state.recipeSchedulesLength;

                  if (categoriesLength != null &&
                      recipeSchedulesLength != null) {
                    return UserStatus(
                      recipeSchedulesLength: recipeSchedulesLength,
                      categoriesLength: categoriesLength,
                    );
                  }
                }
                return const YourStatusNewGuide();
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 1,
                ),
                InkWell(
                  onTap: () async {
                    if (await Permission.camera.request().isGranted &&
                        await Permission.storage.request().isGranted) {
                      Navigator.pushNamed(context, CameraPage.id);
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => const MessageDialog(
                          title: 'Permission is required!',
                          message: kPermissionDenniedDialogMessage,
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Start scanning again!',
                          style: TextStyle(
                            color: kBlackPrimary,
                            fontFamily: 'Montserrat',
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UserStatus extends StatelessWidget {
  const UserStatus({
    Key? key,
    required this.categoriesLength,
    required this.recipeSchedulesLength,
  }) : super(key: key);

  final int categoriesLength;
  final int recipeSchedulesLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hi! again welcome to KUBO',
          style: TextStyle(
            color: kBlackPrimary,
            fontFamily: 'Montserrat Bold',
            fontSize: 18.0,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Text(
          "Here's your status: ",
          style: TextStyle(
            color: kBlackPrimary,
            fontFamily: 'Montserrat',
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        Row(
          children: [
            const CircleAvatar(
              radius: 6,
              backgroundColor: kBrownPrimary,
            ),
            const SizedBox(
              width: 10.0,
            ),
            RichText(
              text: TextSpan(
                text: '${recipeSchedulesLength.toString()} ',
                style: const TextStyle(
                  color: kBlackPrimary,
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                children: const [
                  TextSpan(
                    text: ' upcoming schedules',
                    style: TextStyle(
                      color: kBlackPrimary,
                      fontFamily: 'Montserrat',
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            const CircleAvatar(
              radius: 6,
              backgroundColor: kBrownPrimary,
            ),
            const SizedBox(
              width: 10.0,
            ),
            RichText(
              text: TextSpan(
                text: 'You scanned ',
                style: const TextStyle(
                  color: kBlackPrimary,
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${categoriesLength.toString()} vegetables',
                    style: const TextStyle(
                      color: kBlackPrimary,
                      fontFamily: 'Montserrat',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class YourStatusNewGuide extends StatelessWidget {
  const YourStatusNewGuide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome to KUBO',
          style: TextStyle(
            color: kBlackPrimary,
            fontFamily: 'Montserrat Bold',
            fontSize: 18.0,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        RichText(
          text: TextSpan(
            text: 'Since you are new, you can start exploring ',
            style: const TextStyle(
              color: kBlackPrimary,
              fontFamily: 'Montserrat',
              fontSize: 16.0,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'here',
                style: const TextStyle(
                  color: kGreenPrimary,
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(
                      context,
                      RecipesPage.id,
                      arguments: RecipesPageArguments(),
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
