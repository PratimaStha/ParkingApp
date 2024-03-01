import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking/core/app/states.dart';
import 'package:flutter_parking/secure_storage.dart';

import 'package:http/http.dart' as http;

import '../../../core/app/enums.dart';
import '../../../core/configs/api_config.dart';
import '../../../core/development/console.dart';
import '../../../models/book_slot_response_model.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit() : super(const MyProfileState());

  Future<void> getMyProfile(
    BuildContext context,
  ) async {
    try {
      emit(state.copyWith(
        message: "My Profile fetching, Please wait...",
        status: MyProfileStatus.loading,
      ));
      var response = await http.get(
        Uri.parse("${ApiConfig.baseUrl}/user/myProfile"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${SharedPref.getToken()}"
        },
      );

      console(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        User result = User.fromJson(
            json.decode(utf8.decode(response.bodyBytes).toString()));
        logger(result, loggerType: LoggerType.success);

        emit(
          state.copyWith(
            status: MyProfileStatus.success,
            message: "My Profile fetched successfully",
            userProfile: result,
          ),
        );
      } else {
        throw json.decode(response.body)["errMessage"];
      }
    } catch (e) {
      logger(e, loggerType: LoggerType.error);
      emit(state.copyWith(
          message: e.toString(), status: MyProfileStatus.failure));
    }
  }
}
