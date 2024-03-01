import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking/pages/auth/forgot_password/components/cubit/forgot_password_cubit.dart';
import 'package:flutter_parking/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../../../core/app/enums.dart';
import '../../../../../../core/development/console.dart';
import '../../../../../core/configs/api_config.dart';
import '../../../models/login_response_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  TextEditingController get loginEmailOrPhoneNumberController =>
      _loginEmailController;
  TextEditingController get loginPasswordController => _loginPasswordController;

  Future<void> login(BuildContext context, {bool? isFromLogin = true}) async {
    try {
      emit(state.copyWith(
        message: isFromLogin ?? false
            ? "Logging, Please wait..."
            : "Resetting Password, Please wait...",
        status: LoginStatus.loading,
      ));
      var response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/user/login"),
        body: json.encode({
          'email': isFromLogin ?? false
              ? BlocProvider.of<LoginCubit>(context)
                  ._loginEmailController
                  .text
                  .trim()
              : BlocProvider.of<ForgotPasswordCubit>(context)
                  .forgotEmailController
                  .text
                  .trim(),
          'password': isFromLogin ?? false
              ? BlocProvider.of<LoginCubit>(context)
                  ._loginPasswordController
                  .text
                  .trim()
              : BlocProvider.of<ForgotPasswordCubit>(context)
                  .forgotPasswordController
                  .text
                  .trim(),
          'updatedPassword': isFromLogin ?? false
              ? null
              : BlocProvider.of<ForgotPasswordCubit>(context)
                  .forgotPasswordController
                  .text
                  .trim(),
        }),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        LoginResponseModel result = loginResponseModelFromJson(
            utf8.decode(response.bodyBytes).toString());
        logger(result, loggerType: LoggerType.success);

        // await sl.get<SaveCredentialsUsecase>().call(SaveCredentialsRequestModel(
        //       token: result.userProfile?.accessToken.toString(),
        //       userId: result.userProfile?.id.toString(),
        //       email: result.userProfile?.email.toString(),
        //       isGoogleSignIn: false,
        //       name: result.userProfile?.name?.trim(),
        //     ));

        consolelog(result.userProfile?.accessToken.toString());

        SharedPref.setAuthToken(
            result.userProfile?.accessToken.toString() ?? "");

        emit(
          state.copyWith(
            status: LoginStatus.success,
            message: "Login successfully",
            loginResponseModel: result,
          ),
        );
      } else {
        throw json.decode(response.body)["errMessage"];
      }
    } catch (e) {
      logger(e, loggerType: LoggerType.error);
      emit(state.copyWith(message: e.toString(), status: LoginStatus.failure));
    }
  }
}
