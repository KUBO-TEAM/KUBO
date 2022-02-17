import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';

class AgendaModalForm extends StatefulWidget {
  const AgendaModalForm({Key? key}) : super(key: key);

  @override
  State<AgendaModalForm> createState() => _AgendaModalFormState();
}

class _AgendaModalFormState extends State<AgendaModalForm> {
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
                  // BlocProvider.of<AgendaCubit>(context, listen: false)
                  //     .addTask(agendaTitle);
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
