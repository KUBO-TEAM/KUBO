import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/constants/colors_constants.dart';
import 'package:kubo/modules/agenda/bloc/agenda_cubit.dart';
import 'package:kubo/modules/agenda/states/agenda.state.dart';

class AgendaPage extends StatelessWidget {
  static const String id = 'agenda_page';
  const AgendaPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: kGreenPrimary,
        foregroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(16, 52, 16, 10),
                      child: AddAgendaScreen(),
                    )),
              );
            },
          );
        },
      ),
      backgroundColor: Colors.white,
      body: const SafeArea(child: AgendaState()),
    );
  }
}

class AddAgendaScreen extends StatefulWidget {
  const AddAgendaScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddAgendaScreen> createState() => _AddAgendaScreenState();
}

class _AddAgendaScreenState extends State<AddAgendaScreen> {
  late String agendaTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Task',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kBrownPrimary,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          style: const TextStyle(
              fontStyle: FontStyle.normal,
              decorationColor: kGreenPrimary,
              color: kGreenPrimary,
              fontSize: 22),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            prefixIcon: const Icon(Icons.short_text_outlined,
                color: kGreenPrimary, size: 30),
            suffixIcon: IconButton(
                icon: const Icon(
                  Icons.add_circle_rounded,
                  color: kBrownPrimary,
                  size: 30,
                ),
                splashColor: Colors.green.shade600,
                tooltip: "Send Message",
                onPressed: () {
                  BlocProvider.of<AgendaCubit>(context, listen: false)
                      .addTask(agendaTitle);
                  Navigator.pop(context);
                }),
            fillColor: kBackgroundGrey,
            filled: true,
            focusColor: kGreenPrimary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
          autofocus: true,
          textAlign: TextAlign.start,
          onChanged: (value) {
            agendaTitle = value;
          },
        ),
      ],
    );
  }
}
