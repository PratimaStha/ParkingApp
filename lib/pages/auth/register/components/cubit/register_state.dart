part of 'register_cubit.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final String? message;
  final RegisterStatus status;
  const RegisterState({
    this.message,
    this.status = RegisterStatus.initial,
  });

  RegisterState copyWith({
    String? message,
    RegisterStatus? status,
  }) {
    return RegisterState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [message];
}
