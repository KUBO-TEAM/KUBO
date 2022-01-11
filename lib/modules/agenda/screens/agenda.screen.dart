import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/modules/agenda/models/agenda.model.dart';

import 'package:kubo/modules/agenda/states/agenda.state.dart';
import 'package:provider/provider.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({Key? key}) : super(key: key);

  static const String id = 'agenda_screen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AgendaList(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: kGreenPrimary,
          foregroundColor: Colors.white,
          onPressed: () => {},
        ),
        backgroundColor: Colors.white,
        body: SafeArea(child: AgendaState()),
      ),
    );
  }
}
