// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'otp_cubit.dart';

enum OtpStatus { loading, success, failure }

class OtpState extends Equatable {
  final String? message;
  final OtpStatus status;
  const OtpState({
    this.message,
    this.status = OtpStatus.loading,
  });

  @override
  List<Object?> get props => [status, message];

  OtpState copyWith({
    String? message,
    OtpStatus? status,
  }) {
    return OtpState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
