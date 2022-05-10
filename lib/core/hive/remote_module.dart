import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@module
abstract class RemoteModule {
  http.Client get prefs => http.Client();
}
