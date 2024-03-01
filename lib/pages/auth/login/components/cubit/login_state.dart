part of 'login_cubit.dart';

enum LoginStatus {
  loading,
  success,
  failure,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final String? message;
  final LoginResponseModel? loginResponseModel;
  const LoginState({
    this.status = LoginStatus.loading,
    this.message,
    this.loginResponseModel,
  });

  @override
  List<Object?> get props => [status, message, loginResponseModel];

  LoginState copyWith({
    LoginStatus? status,
    String? message,
    LoginResponseModel? loginResponseModel,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
      loginResponseModel: loginResponseModel ?? this.loginResponseModel,
    );
  }
}
