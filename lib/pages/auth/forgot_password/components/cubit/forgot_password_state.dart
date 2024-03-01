// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_cubit.dart';

enum ForgotPasswordStatus {
  loading,
  success,
  failure,
}

class ForgotPasswordState extends Equatable {
  final ForgotPasswordStatus status;
  final String? message;
  // final LoginResponseModel? loginResponseModel;
  const ForgotPasswordState({
    this.status = ForgotPasswordStatus.loading,
    this.message,
    // this.loginResponseModel,
  });

  @override
  List<Object?> get props => [message, status];

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    String? message,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
