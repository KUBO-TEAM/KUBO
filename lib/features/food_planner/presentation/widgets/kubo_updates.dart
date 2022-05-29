import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/icon_title.dart';
import 'package:kubo/features/food_planner/presentation/widgets/show_available_ingredients_dialog.dart';

const _title = 'Kubo Updates!';
const _subTitle = 'Please be informed that:';
const _icon = Icons.trending_up;

const _cardRadius = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  ),
);

class KuboUpdates extends StatelessWidget {
  const KuboUpdates({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: _cardRadius,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
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
            Row(
              children: [
                const CircleAvatar(
                  radius: 6,
                  backgroundColor: kGreenPrimary,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                RichText(
                  text: const TextSpan(
                    text: 'You can scan ',
                    style: TextStyle(
                      color: kBlackPrimary,
                      fontFamily: 'Montserrat',
                      fontSize: 16.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '10 vegetables',
                        style: TextStyle(
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
            Row(
              children: const [
                CircleAvatar(
                  radius: 6,
                  backgroundColor: kGreenPrimary,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '50+ filipino recipes are available',
                  style: TextStyle(
                    color: kBlackPrimary,
                    fontFamily: 'Montserrat',
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ShowAvailableIngredientsDialog();
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
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
                      'Show 10 vegetables',
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
        ),
      ),
    );
  }
}
