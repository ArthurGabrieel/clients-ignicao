part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  LoginEvent(this.dto);

  final LoginDto dto;

  @override
  List<Object?> get props => [dto];
}

class RegisterEvent extends AuthEvent {
  RegisterEvent(this.dto);

  final RegisterDto dto;

  @override
  List<Object?> get props => [dto];
}

class ToogleAuthEvent extends AuthEvent {
  ToogleAuthEvent(this.isLogin);

  final bool isLogin;

  @override
  List<Object?> get props => [isLogin];
}
