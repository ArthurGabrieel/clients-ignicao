part of 'clients_bloc.dart';

class ClientsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class Reset extends ClientsEvent {}

class FetchClients extends ClientsEvent {}

class AddClient extends ClientsEvent {
  AddClient({required this.dto});

  final RegisterDto dto;

  @override
  List<Object?> get props => [dto];
}

class DeleteClient extends ClientsEvent {
  DeleteClient({required this.dto});

  final DeleteClientDto dto;

  @override
  List<Object?> get props => [dto];
}

class UpdateClient extends ClientsEvent {
  UpdateClient({required this.dto});

  final UpdateClientDto dto;

  @override
  List<Object?> get props => [dto];
}

class UpdatePassword extends ClientsEvent {
  UpdatePassword({required this.dto});

  final UpdatePasswordDto dto;

  @override
  List<Object?> get props => [dto];
}

class GetClient extends ClientsEvent {
  GetClient({required this.dto});

  final GetClientDto dto;

  @override
  List<Object?> get props => [dto];
}

class SearchClient extends ClientsEvent {
  SearchClient({required this.dto});

  final SearchClientDto dto;

  @override
  List<Object?> get props => [dto];
}
