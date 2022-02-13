import 'package:bloc/bloc.dart';
import 'package:kubo/core/temp/agenda.model.dart';

part 'agenda_state.dart';

class AgendaCubit extends Cubit<AgendaCubitState> {
  AgendaCubit() : super(AgendaCubitState(agendas: []));

  void addTask(String newAgendaTitle) {
    final agenda = Agenda(name: newAgendaTitle);
    final _agendas = state.agendas;
    _agendas.add(agenda);
    emit(AgendaCubitState(agendas: _agendas));
  }

  void removeTask(Agenda agenda) {
    final _agendas = state.agendas;
    _agendas.remove(agenda);
    emit(AgendaCubitState(agendas: _agendas));
  }
}
