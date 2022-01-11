
import 'dart:collection';
import 'package:flutter/foundation.dart';

class Agenda {
  final String name;
  final Duration time;
  DateTime _deadline = DateTime.now();

  String get deadline => _deadline.add(time).toString();

  Agenda({required this.name, this.time = const Duration(days: 7)});

  String printDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(time.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(time.inSeconds.remainder(60));
    String twoDigitHours = twoDigits(time.inHours.remainder(60));
    return "${twoDigits(time.inHours)}:$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }


}

class AgendaList extends ChangeNotifier{
  List<Agenda> _agendas = [
    Agenda(name: "Agenda 1"),
    Agenda(name: "Agenda 2"),
    Agenda(name: "Agenda 3"),
    Agenda(name: "Agenda 4"),
    Agenda(name: "Agenda 5"),
    Agenda(name: "Agenda 6"),
    Agenda(name: "Agenda 7"),
    Agenda(name: "Agenda 8"),
    Agenda(name: "Agenda 9"),
  ];

  UnmodifiableListView<Agenda> get agendas {
    return UnmodifiableListView(_agendas);
  }

  int get agendaCount {
    return _agendas.length;
  }

  void addTask(String newAgendaTitle) {
    final agenda = Agenda(name: newAgendaTitle);
    _agendas.add(agenda);
    notifyListeners();
  }

  void updateTask(Agenda agenda) {
    // Agenda.toggleDone();
    notifyListeners();
  }

  void deleteTask(Agenda agenda) {
    _agendas.remove(agenda);
    notifyListeners();
  }
}