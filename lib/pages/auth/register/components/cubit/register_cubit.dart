import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking/pages/auth/models/register_response_model.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/abstract/reset_text_editing_controller.dart';
import '../../../../../core/app/enums.dart';
import '../../../../../core/configs/api_config.dart';
import '../../../../../core/development/console.dart';
import '../../../models/register_request_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState>
    implements ResetTextEditingController {
  RegisterCubit() : super(const RegisterState());

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _registerFirstNameController =
      TextEditingController();
  final TextEditingController _registerLastNameController =
      TextEditingController();
  final TextEditingController _registerPasswordController =
      TextEditingController();
  final TextEditingController _registerConfirmPasswordController =
      TextEditingController();

  TextEditingController get registerEmailController => _registerEmailController;
  TextEditingController get registerFirstNameController =>
      _registerFirstNameController;
  TextEditingController get registerLastNameController =>
      _registerLastNameController;
  TextEditingController get registerPasswordController =>
      _registerPasswordController;
  TextEditingController get registerConfirmPasswordController =>
      _registerConfirmPasswordController;

  ValueNotifier<String> chooseRole = ValueNotifier<String>("");

  Future<void> register() async {
    try {
      emit(state.copyWith(
        message: "Registering, please wait...",
        status: RegisterStatus.loading,
      ));

      var response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/user/register"),
        body: json.encode({
          'name':
              "${_registerFirstNameController.text} ${_registerLastNameController.text}",
          'email': _registerEmailController.text,
          'password': _registerPasswordController.text,
        }),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        RegisterResponseModel result = registerResponseModelFromJson(
            utf8.decode(response.bodyBytes).toString());

        logger(result.otpCode, loggerType: LoggerType.success);
        emit(
          (state.copyWith(
            status: RegisterStatus.success,
            message: result.message,
          )),
        );
      } else {
        throw json.decode(response.body)["errMessage"];
      }
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(), status: RegisterStatus.failure));
    }
  }

  @override
  void reset() {
    registerEmailController.clear();
    registerFirstNameController.clear();
    registerLastNameController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
    chooseRole.value = "";
  }
}
