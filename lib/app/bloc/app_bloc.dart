import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prosoft_task/api/authentication/i_authentication_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required IAuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AppState.unauthenticated()) {
    on<AppTokenChecked>(_onTokenChecked);
    on<AppLogoutRequested>(_onLogoutRequested);
  }

  final IAuthenticationRepository _authenticationRepository;

  Future<void> _onTokenChecked(
      AppTokenChecked event, Emitter<AppState> emit) async {
    emit(
      (event.token.isNotEmpty)
          ? AppState.authenticated(event.token)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
    emit(const AppState.unauthenticated());
  }
}
