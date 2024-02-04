import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../injection_container.dart';
import '../../../../shared/network/storage.dart';
import '../../../clients/data/usecases/register_usecase.dart';
import '../../../clients/domain/dto/register_dto.dart';
import '../../data/dto/login_dto.dart';
import '../../data/usecases/login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase = sl<LoginUseCase>();
  final RegisterUseCase registerUseCase = sl<RegisterUseCase>();
  final SecureStorage secureStorage = sl<SecureStorage>();

  AuthBloc() : super(Logging()) {
    on<ToogleAuthEvent>((event, emit) {
      emit(event.isLogin ? Registering() : Logging());
    });

    on<LoginEvent>((event, emit) async {
      emit(Loading());

      final result = await loginUseCase(event.dto);

      result.fold(
        (failure) => emit(Error(message: failure.props.first.toString())),
        (token) {
          secureStorage.saveToken(token);
          emit(Logged(token: token));
        },
      );
    });

    on<RegisterEvent>((event, emit) async {
      emit(Loading());

      final result = await registerUseCase(event.dto);

      result.fold(
        (failure) => emit(Error(message: failure.props.first.toString())),
        (output) {
          emit(Registered());
        },
      );
    });
  }
}
