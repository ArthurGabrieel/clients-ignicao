import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../injection_container.dart';
import '../../../../shared/data/usecases/usecase.dart';
import '../../data/usecases/delete_client_usecase.dart';
import '../../data/usecases/get_all_clients_usecase.dart';
import '../../data/usecases/get_client_usecase.dart';
import '../../data/usecases/register_usecase.dart';
import '../../data/usecases/search_client_usecase.dart';
import '../../data/usecases/update_client_usecase.dart';
import '../../data/usecases/update_password_usecase.dart';
import '../../domain/dto/delete_client_dto.dart';
import '../../domain/dto/get_client_dto.dart';
import '../../domain/dto/register_dto.dart';
import '../../domain/dto/search_client_dto.dart';
import '../../domain/dto/update_client_dto.dart';
import '../../domain/dto/update_password_dto.dart';
import '../../domain/entities/client_output.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  final registerUseCase = sl<RegisterUseCase>();
  final getAllClientUseCase = sl<GetAllClientUseCase>();
  final getClientUseCase = sl<GetClientUseCase>();
  final searchClientUseCase = sl<SearchClientUseCase>();
  final updateClientUseCase = sl<UpdateClientUseCase>();
  final updatePasswordUseCase = sl<UpdatePasswordUseCase>();
  final deleteClientUseCase = sl<DeleteClientUseCase>();

  ClientsBloc() : super(Empty()) {
    on<FetchClients>((event, emit) async {
      emit(Loading());

      final result = await getAllClientUseCase(NoParams());

      result.fold(
        (failure) => emit(Error(message: failure.props.first.toString())),
        (clients) => emit(ClientsLoaded(clients: clients)),
      );
    });

    on<GetClient>((event, emit) async {
      emit(Loading());

      final result = await getClientUseCase(event.dto);

      result.fold(
        (failure) => emit(Error(message: failure.props.first.toString())),
        (client) => emit(ClientLoaded(client: client)),
      );
    });

    on<SearchClient>((event, emit) async {
      emit(Loading());

      final result = await searchClientUseCase(event.dto);

      result.fold(
        (failure) => emit(Error(message: 'Cliente não encontrado')),
        (client) => emit(ClientUpdated(client: client)),
      );
    });

    on<UpdateClient>((event, emit) async {
      emit(Loading());

      final result = await updateClientUseCase(event.dto);

      result.fold(
        (failure) => emit(Error(message: failure.props.first.toString())),
        (client) => emit(ClientLoaded(client: client)),
      );
    });

    on<UpdatePassword>((event, emit) async {
      emit(Loading());

      final result = await updatePasswordUseCase(event.dto);

      result.fold(
        (failure) => emit(Error(message: 'Senha incorreta')),
        (client) => emit(ClientUpdated(client: client)),
      );
    });

    on<AddClient>((event, emit) async {
      emit(Loading());

      final result = await registerUseCase(event.dto);

      result.fold(
        (failure) => emit(Error(message: failure.props.first.toString())),
        (client) => emit(ClientLoaded(client: client)),
      );
    });

    on<DeleteClient>((event, emit) async {
      emit(Loading());

      final result = await deleteClientUseCase(event.dto);

      result.fold(
        (failure) => emit(Error(message: failure.props.first.toString())),
        (_) => emit(ClientDeleted()),
      );
    });
  }
}
