import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/string_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/icon_title.dart';
import 'package:kubo/features/food_planner/presentation/widgets/message_dialog.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/camera_page.dart';
import 'package:permission_handler/permission_handler.dart';

const _title = 'Trained Veggies';
const _subTitle = 'Available Vegetables';
const _icon = Icons.precision_manufacturing;

const _cardRadius = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  ),
);

class TrainedVeggies extends StatelessWidget {
  const TrainedVeggies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: _cardRadius,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: 150,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                  const Text(
                    _subTitle,
                    style: TextStyle(
                      color: kBlackPrimary,
                      fontFamily: 'Montserrat Bold',
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    children: kBboxColorClass.entries.map((entry) {
                      return Chip(
                        backgroundColor: Colors.white,
                        elevation: 5,
                        avatar: CircleAvatar(
                          radius: 6,
                          backgroundColor: entry.value,
                        ),
                        label: Text(
                          entry.key,
                          style: const TextStyle(
                            color: kBlackPrimary,
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
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
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
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
                          'Scan ingredients now!',
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
