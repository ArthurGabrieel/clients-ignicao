part of 'auth_bloc.dart';

class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Logging extends AuthState {}

class Registering extends AuthState {}

class Loading extends AuthState {}

class Logged extends AuthState {
  Logged({required this.token});

  final String token;

  @override
  List<Object?> get props => [token];
}

class Registered extends AuthState {}

class Error extends AuthState {
  Error({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
