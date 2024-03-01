import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking/core/configs/api_config.dart';
import 'package:flutter_parking/pages/auth/login/components/cubit/login_cubit.dart';
import 'package:flutter_parking/pages/auth/models/forgot_password_response_model.dart';
import 'package:flutter_parking/pages/auth/register/components/cubit/register_cubit.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/app/enums.dart';
import '../../../../../core/development/console.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState());

  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController _forgotEmailController = TextEditingController();
  final TextEditingController _forgotPasswordController =
      TextEditingController();
  final TextEditingController _forgotConfirmPasswordController =
      TextEditingController();

  TextEditingController get forgotEmailController => _forgotEmailController;
  TextEditingController get forgotPasswordController =>
      _forgotPasswordController;
  TextEditingController get forgotConfirmPasswordController =>
      _forgotConfirmPasswordController;

  Future<void> forgotPassword(BuildContext context) async {
    try {
      emit(state.copyWith(
        message: "Requesting, Please wait...",
        status: ForgotPasswordStatus.loading,
      ));

      var response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/user/sendOtp"),
        body: json.encode({
          "email": BlocProvider.of<LoginCubit>(context)
              .loginEmailOrPhoneNumberController
              .text
              .trim(),
        }),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ForgotPasswordResponseModel result =
            forgotPasswordResponseModelFromJson(
                utf8.decode(response.bodyBytes).toString());

        logger(result, loggerType: LoggerType.success);

        emit(
          state.copyWith(
            status: ForgotPasswordStatus.success,
            message: result.otpMessage,
          ),
        );
      } else {
        throw json.decode(response.body)["errMessage"];
      }
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(), status: ForgotPasswordStatus.failure));
    }
  }
}
