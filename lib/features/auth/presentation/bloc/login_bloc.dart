import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base_project/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLogin);
  }

  Future<void> _onLogin(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final result = await loginUseCase(LoginParams(event.email, event.password));
    result.fold((failure) {
      emit(LoginFailure(message: failure.message));
    }, (user) {
      emit(LoginSuccess(user: user));
    });
  }
}
