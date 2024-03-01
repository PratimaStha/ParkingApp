import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking/core/app/states.dart';
import 'package:flutter_parking/models/add_book_response_model.dart';
import 'package:flutter_parking/secure_storage.dart';

import 'package:http/http.dart' as http;

import '../../../core/app/enums.dart';
import '../../../core/configs/api_config.dart';
import '../../../core/development/console.dart';
import '../../../models/book_slot_response_model.dart';

part 'book_slot_state.dart';

class BookSlotCubit extends Cubit<BookSlotState> {
  BookSlotCubit() : super(const BookSlotState());

  Future<void> bookSlot(
    BuildContext context, {
    String? numberPlate,
    double? totalAmt,
  }) async {
    try {
      emit(state.copyWith(
        message: "Booking, Please wait...",
        status: BookSlotStatus.addBookLoading,
      ));
      var response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/slot/bookings"),
        body: json.encode({
          "numberPlate": numberPlate,
          "price": totalAmt?.toInt(),
          "spotId": selectedSlotNotifier.value,
          "startTime": checkInDateNotifier.value.toString(),
          "endTime": checkOutDateNotifier.value.toString(),
        }),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${SharedPref.getToken()}"
        },
      ).timeout(const Duration(seconds: 10));

      console(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        AddBookSlotResponseModel result = addBookSlotResponseModelFromJson(
            utf8.decode(response.bodyBytes).toString());
        logger(result, loggerType: LoggerType.success);

        emit(
          state.copyWith(
            status: BookSlotStatus.addBookSuccess,
            message: "BookSlot added successfully",
            addBookSlotResponseModel: result,
          ),
        );
      } else {
        throw json.decode(response.body)["errMessage"];
      }
    } catch (e) {
      logger(e, loggerType: LoggerType.error);
      emit(state.copyWith(
          message: e.toString(), status: BookSlotStatus.addBookFailure));
    }
  }

  Future<void> getAllBookSlot(
    BuildContext context,
  ) async {
    try {
      emit(state.copyWith(
        message: "Get all booking, Please wait...",
        status: BookSlotStatus.getBookLoading,
      ));
      var response = await http.get(
        Uri.parse("${ApiConfig.baseUrl}/slot/bookings"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${SharedPref.getToken()}"
        },
      ).timeout(const Duration(seconds: 10));

      console(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        BookSlotResponseModel result = bookSlotResponseModelFromJson(
            utf8.decode(response.bodyBytes).toString());
        logger(result, loggerType: LoggerType.success);

        emit(
          state.copyWith(
            status: BookSlotStatus.getBookSuccess,
            message: "Book slot fetched successfully",
            bookSlotResponseModel: result,
          ),
        );
      } else {
        throw json.decode(response.body)["errMessage"];
      }
    } catch (e) {
      logger(e, loggerType: LoggerType.error);
      emit(state.copyWith(
          message: e.toString(), status: BookSlotStatus.getBookFailure));
    }
  }

  Future<void> getMyBookSlot(
    BuildContext context,
  ) async {
    try {
      emit(state.copyWith(
        message: "Get my booking, Please wait...",
        status: BookSlotStatus.getMyBookLoading,
      ));
      var response = await http.get(
        Uri.parse("${ApiConfig.baseUrl}/slot/my/bookings"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${SharedPref.getToken()}"
        },
      ).timeout(const Duration(seconds: 10));

      console(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        BookSlotResponseModel result = bookSlotResponseModelFromJson(
            utf8.decode(response.bodyBytes).toString());
        logger(result, loggerType: LoggerType.success);

        emit(
          state.copyWith(
            status: BookSlotStatus.getMyBookSuccess,
            message: "My book slot fetched successfully",
            myBookSlotResponseModel: result,
          ),
        );
      } else {
        throw json.decode(response.body)["errMessage"];
      }
    } catch (e) {
      logger(e, loggerType: LoggerType.error);
      emit(state.copyWith(
        message: e.toString(),
        status: BookSlotStatus.getMyBookFailure,
      ));
    }
  }

  Future<void> deleteBookSlot(BuildContext context,
      {required String bookingId}) async {
    try {
      emit(state.copyWith(
        message: "Delete booking, Please wait...",
        status: BookSlotStatus.deleteLoading,
      ));
      var response = await http.delete(
        Uri.parse("${ApiConfig.baseUrl}/slot/bookings/$bookingId"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${SharedPref.getToken()}"
        },
      ).timeout(const Duration(seconds: 10));

      console(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // BookSlotResponseModel result = bookSlotResponseModelFromJson(
        //     utf8.decode(response.bodyBytes).toString());
        // logger(result, loggerType: LoggerType.success);

        emit(
          state.copyWith(
            status: BookSlotStatus.deleteSuccess,
            message: "Booking deleted successfully",
          ),
        );
      } else {
        throw json.decode(response.body)["errMessage"];
      }
    } catch (e) {
      logger(e, loggerType: LoggerType.error);
      emit(state.copyWith(
        message: e.toString(),
        status: BookSlotStatus.deleteFailure,
      ));
    }
  }

  Future<void> updateBookingSlot(BuildContext context,
      {required String bookingId}) async {
    try {
      emit(state.copyWith(
        message: "Update booking to reserved, Please wait...",
        status: BookSlotStatus.updateReservedLoading,
      ));
      var response = await http.patch(
        Uri.parse(
            "${ApiConfig.baseUrl}/slot/bookings/$bookingId/update-to-reserved"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${SharedPref.getToken()}"
        },
      ).timeout(const Duration(seconds: 10));

      console(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(
          state.copyWith(
            status: BookSlotStatus.updateReservedSuccess,
            message: "Booking updating to reserved successfully",
          ),
        );
      } else {
        throw json.decode(response.body)["errMessage"];
      }
    } catch (e) {
      logger(e, loggerType: LoggerType.error);
      emit(state.copyWith(
        message: e.toString(),
        status: BookSlotStatus.updateReservedFailure,
      ));
    }
  }
}
