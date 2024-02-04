part of 'clients_bloc.dart';

abstract class ClientsState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends ClientsState {}

class Loading extends ClientsState {}

class ClientCreated extends ClientsState {}

class ClientsLoaded extends ClientsState {
  ClientsLoaded({required this.clients});

  final List<ClientOutputEntity> clients;

  @override
  List<Object> get props => [clients];
}

class ClientLoaded extends ClientsState {
  ClientLoaded({required this.client});

  final ClientOutputEntity client;

  @override
  List<Object> get props => [client];
}

class ClientUpdated extends ClientsState {
  ClientUpdated({required this.client});

  final ClientOutputEntity client;

  @override
  List<Object> get props => [client];
}

class ClientFound extends ClientsState {
  ClientFound({required this.client});

  final ClientOutputEntity client;

  @override
  List<Object> get props => [client];
}

class ClientDeleted extends ClientsState {}

class Error extends ClientsState {
  Error({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
