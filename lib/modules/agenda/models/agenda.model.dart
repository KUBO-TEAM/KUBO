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
