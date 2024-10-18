part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  inProgress,
  success,
  failure,
  canceled,
  imageSuccess,
  imageFailure,
}

final class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
  });

  final AuthStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
