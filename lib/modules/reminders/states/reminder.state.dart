import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/modules/reminders/models/reminders.model.dart';
import 'package:kubo/widgets/buttons/icon.button.dart';
import 'package:kubo/widgets/clippers/list.clipper.dart';

class ReminderState extends StatefulWidget {
  const ReminderState({Key? key}) : super(key: key);

  @override
  _ReminderStateState createState() => _ReminderStateState();
}

class _ReminderStateState extends State<ReminderState> {
  List<Reminders> reminders = [
    Reminders(title: "Reminder Title", subtitle: "Some Caption Here Like This."),
    Reminders(title: "Reminder Title", subtitle: "Some Caption Here Like This."),
    Reminders(title: "Reminder Title", subtitle: "Some Caption Here Like This."),
    Reminders(title: "Reminder Title", subtitle: "Some Caption Here Like This."),
    Reminders(title: "Reminder Title", subtitle: "Some Caption Here Like This."),
    Reminders(title: "Reminder Title", subtitle: "Some Caption Here Like This."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kGreenPrimary,
        body: SafeArea(
          child: Stack(
            children: [
              const ListClipper(
                color: Colors.white,
              ),
              Column(
                children: [
                  SizedBox(
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            const Text(
                              "Reminders",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Arvo Bold',
                              ),
                            ),
                            const Spacer(),
                            const Spacer(),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: reminders.length,
                        itemBuilder: (context, index) {
                          Reminders reminder = reminders[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            child: Card(
                              color: const Color(0xffFFF6E8),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                    child: ListTile(
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        margin: const EdgeInsets.all(1.0),
                                        decoration: const BoxDecoration(
                                            color: Color(0xffFFE6C0),
                                            shape: BoxShape.circle),
                                        child: Center(
                                            child: Text(
                                          (index + 1).toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        )),
                                      ),
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          reminder.title,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      subtitle: Text(
                                        reminder.subtitle,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          );
                        }),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

