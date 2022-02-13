import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;

  const Failure([this.properties = const <dynamic>[]]);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
