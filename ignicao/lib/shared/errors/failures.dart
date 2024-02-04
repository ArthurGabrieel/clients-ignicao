import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.properties = const <dynamic>[]]);

  final List<dynamic> properties;

  @override
  List<Object> get props => <Object>[properties];
}

class ServerFailure extends Failure {}

class NoInternetConnectionFailure extends Failure {}

class InvalidCredential extends Failure {}
