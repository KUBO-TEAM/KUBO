import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/widgets/clippers/image.clipper.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({Key? key}) : super(key: key);

  static const String id = 'agenda_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        backgroundColor: kBackgroundGrey,
        iconTheme: const IconThemeData(
        color: kBlackPrimary, //chang color here
        ),
      ),
      // body: const ImageClipper(),
    );
  }
}

