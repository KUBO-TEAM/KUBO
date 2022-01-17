import 'dart:collection';
import 'package:flutter/foundation.dart';

class Agenda {
  final String name;
  final Duration time;
  final DateTime _deadline = DateTime.now();

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

class AgendaList extends ChangeNotifier {
  final List<Agenda> _agendas = [];

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
    notifyListeners();
  }

  void deleteTask(Agenda agenda) {
    _agendas.remove(agenda);
    notifyListeners();
  }
}
