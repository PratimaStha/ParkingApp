import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking/core/configs/api_config.dart';
import 'package:http/http.dart' as http;

import '../../../../../../core/app/enums.dart';
import '../../../../../../core/development/console.dart';
import '../../../models/register_response_model.dart';
import '../../../register/components/cubit/register_cubit.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(const OtpState());
  GlobalKey<FormState> pinputFormKey = GlobalKey<FormState>();
  final TextEditingController _pinputEditingController =
      TextEditingController();

  TextEditingController get pinputEditingController => _pinputEditingController;

  Future<void> otpVerify(BuildContext context,
      {bool? isFromRegister = true}) async {
    try {
      emit(state.copyWith(
        message: "Otp Verifying, please wait...",
        status: OtpStatus.loading,
      ));

      // final response = await sl.get<OtpUsecase>().call(
      //       RegisterRequestModel(
      //         email: isFromRegister ?? false
      //             ? sl.get<RegisterCubit>().registerEmailController.text.trim()
      //             : sl
      //                 .get<ForgotPasswordCubit>()
      //                 .forgotEmailController
      //                 .text
      //                 .trim(),
      //         otp: sl.get<OtpCubit>().pinputEditingController.text,
      //       ),
      //     );

      var response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/user/verify-OTP"),
        body: json.encode({
          'name':
              "${BlocProvider.of<RegisterCubit>(context).registerFirstNameController.text} ${BlocProvider.of<RegisterCubit>(context).registerLastNameController.text}",
          'email': BlocProvider.of<RegisterCubit>(context)
              .registerEmailController
              .text,
          'password': BlocProvider.of<RegisterCubit>(context)
              .registerPasswordController
              .text,
          'otp': _pinputEditingController.text,
        }),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        RegisterResponseModel result = registerResponseModelFromJson(
            utf8.decode(response.bodyBytes).toString());

        logger(result, loggerType: LoggerType.success);
        emit(
          (state.copyWith(
            status: OtpStatus.success,
            message: result.message,
          )),
        );
      } else {
        throw json.decode(response.body)["errMessage"];
      }
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: OtpStatus.failure));
    }
  }
}
