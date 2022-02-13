import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/blocs/agenda/agenda_cubit.dart';
import 'package:kubo/features/food_planner/presentation/widgets/agenda_card_tile.dart';
import 'package:kubo/features/food_planner/presentation/widgets/agenda_modal_form.dart';
import 'package:kubo/features/food_planner/presentation/widgets/kubo_app_bars.dart';

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
        onPressed: () => _showAgendaBottomModal(context),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<AgendaCubit, AgendaCubitState>(
          builder: (context, state) => Column(
            children: <Widget>[
              const KuboClippedAppBar("Agenda"),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.agendas.length,
                  itemBuilder: (context, index) {
                    var agenda = state.agendas[index];
                    return AgendaCardTile(agenda: agenda);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAgendaBottomModal(BuildContext context) {
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
              child: AgendaModalForm(),
            ),
          ),
        );
      },
    );
  }
}
