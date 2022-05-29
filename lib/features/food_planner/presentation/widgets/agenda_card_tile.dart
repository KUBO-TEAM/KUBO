import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';

class AgendaCardTile extends StatelessWidget {
  const AgendaCardTile({
    Key? key,
    // required this.agenda,
  }) : super(key: key);

  // final Agenda agenda;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: ListTile(
              subtitle: Row(
                children: const [
                  Icon(
                    Icons.access_alarm_sharp,
                    size: 18,
                  ),
                  // Text(agenda.deadline),
                ],
              ),
            ),
          ),
        ),
        IconButton(
            splashColor: kBrownPrimary,
            onPressed: () {
              // BlocProvider.of<AgendaCubit>(context).removeTask(agenda),
            },
            icon: const Icon(
              Icons.delete,
              color: kBrownPrimary,
              size: 30,
            ))
      ]),
    );
  }
}
