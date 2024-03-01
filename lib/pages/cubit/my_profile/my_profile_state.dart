part of 'my_profile_cubit.dart';

enum MyProfileStatus {
  initial,
  loading,
  success,
  failure,
}

class MyProfileState extends Equatable {
  final MyProfileStatus status;
  final String? message;
  final User? userProfile;
  const MyProfileState({
    this.status = MyProfileStatus.initial,
    this.message,
    this.userProfile,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        userProfile,
      ];

  MyProfileState copyWith({
    MyProfileStatus? status,
    String? message,
    User? userProfile,
  }) {
    return MyProfileState(
      status: status ?? this.status,
      message: message ?? this.message,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
