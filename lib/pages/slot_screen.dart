import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking/core/app/dimensions.dart';
import 'package:flutter_parking/core/app/states.dart';
import 'package:flutter_parking/core/development/console.dart';
import 'package:flutter_parking/core/routing/route_navigation.dart';
import 'package:flutter_parking/models/book_slot_response_model.dart';
import 'package:flutter_parking/models/qr_model.dart';
import 'package:flutter_parking/pages/cubit/book_slot/book_slot_cubit.dart';
import 'package:flutter_parking/pages/date_time_picker.dart';
import 'package:flutter_parking/pages/qr.dart';
import 'package:flutter_parking/pages/style.dart';
import 'package:flutter_parking/widgets/custom_dialogs.dart';
import 'package:flutter_parking/widgets/custom_text.dart';
import 'package:flutter_parking/widgets/custom_text_form_field.dart';
import 'package:flutter_parking/widgets/custom_toast.dart';
import 'package:intl/intl.dart';

class SlotScreen extends StatefulWidget {
  final String? parkingName;
  const SlotScreen({super.key, this.parkingName});

  @override
  State<SlotScreen> createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController numberr = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<BookSlotCubit>(context).getAllBookSlot(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookSlotCubit, BookSlotState>(
      listener: (context, state) {
        if (state.status == BookSlotStatus.addBookLoading) {
          CustomDialogs.fullLoadingDialog(
            context: context,
            data: state.message,
          );
        }
        if (state.status == BookSlotStatus.addBookFailure) {
          Navigator.pop(context);
          errorToast(msg: state.message ?? "Something went wrong");
        }
        if (state.status == BookSlotStatus.addBookSuccess) {
          back(context);
          successToast(msg: state.message);

          Map<String, dynamic> data = {
            "name": state.addBookSlotResponseModel?.bookings?.user?.name,
            "email": state.addBookSlotResponseModel?.bookings?.user?.email,
            "price": state.addBookSlotResponseModel?.bookings?.price,
            "startTime": DateFormat("dd, MMM yyyy hh:mm a").format(
                DateTime.parse(
                        state.addBookSlotResponseModel?.bookings?.startTime ??
                            "")
                    .toLocal()),
            "endTime": DateFormat("dd, MMM yyyy hh:mm a").format(DateTime.parse(
                    state.addBookSlotResponseModel?.bookings?.endTime ?? "")
                .toLocal()),
            "numberPlate":
                state.addBookSlotResponseModel?.bookings?.numberPlate,
            "spotNumber": state
                .addBookSlotResponseModel?.bookings?.parkingSpot?.spotNumber,
            "status":
                state.addBookSlotResponseModel?.bookings?.parkingSpot?.status,
          };

          QrModel qrModel = QrModel.fromJson(data);

          navigate(context, QRPage(data: json.encode(qrModel.toJson())));

          BlocProvider.of<BookSlotCubit>(context).getAllBookSlot(context);

          selectedSlotNotifier.value = null;
          numberr.clear();
          checkInDateNotifier.value = null;
          checkOutDateNotifier.value = null;
        }
      },
      child: PopScope(
        onPopInvoked: (didPop) {
          if (didPop) {
            selectedSlotNotifier.value = null;
            numberr.clear();
            checkInDateNotifier.value = null;
            checkOutDateNotifier.value = null;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.parkingName?.toUpperCase() ?? "",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            elevation: 0.5,
          ),
          body: BlocBuilder<BookSlotCubit, BookSlotState>(
            builder: (context, state) {
              if (state.status == BookSlotStatus.getBookLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.status == BookSlotStatus.getBookFailure) {
                return Center(
                  child: Text(state.message ?? "Something went wrong"),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<BookSlotCubit>(context)
                      .getAllBookSlot(context);
                  return Future.value();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  padding: screenLeftRightPadding,
                  child: Column(
                    children: [
                      vSizedBox2,
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.orange,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: const Text(
                                    "Booked",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: const Text(
                                    "Selected",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      vSizedBox2,
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.red,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: const Text(
                                    "Reserved",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: const Text(
                                    "Available",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      vSizedBox3,
                      ValueListenableBuilder(
                        valueListenable: selectedSlotNotifier,
                        builder: (context, value, child) => Wrap(
                          runSpacing: 24,
                          spacing: 36,
                          children: List.generate(
                            4,
                            (index) {
                              Booking? bookingResult = state
                                  .bookSlotResponseModel?.bookings
                                  ?.firstWhere(
                                (element) {
                                  return element.parkingSpot?.spotNumber ==
                                      index + 1;
                                },
                                orElse: () => Booking(),
                              );
                              return GestureDetector(
                                onTap: () {
                                  if (bookingResult?.id != null) {
                                    warningToast(
                                        msg: "This slot is already booked");
                                  } else {
                                    selectedSlotNotifier.value = index + 1;
                                  }
                                },
                                child: Container(
                                  padding: screenPadding,
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color:
                                        selectedSlotNotifier.value == index + 1
                                            ? Colors.green
                                            : bookingResult != null
                                                ? bookingResult.parkingSpot
                                                            ?.status ==
                                                        "reserved"
                                                    ? Colors.red
                                                    : bookingResult.parkingSpot
                                                                ?.status ==
                                                            "available"
                                                        ? Colors.transparent
                                                        : bookingResult
                                                                    .parkingSpot
                                                                    ?.status ==
                                                                "booked"
                                                            ? Colors.orange
                                                            : Colors.white
                                                : Colors.white,
                                    border: Border.all(
                                      color: selectedSlotNotifier.value ==
                                              index + 1
                                          ? AppColors.primaryColor
                                          : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: FittedBox(
                                    child: CustomText.ourText(
                                      "S${index + 1}",
                                      fontSize: 18,
                                      color: selectedSlotNotifier.value ==
                                              index + 1
                                          ? AppColors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      vSizedBox2andHalf,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: numberr,
                            validator: (val) {
                              if (val?.isEmpty ?? false) {
                                return "Please enter numberplate";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Enter number plate",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      vSizedBox2andHalf,
                      CustomText.ourText("CheckIn Date"),
                      vSizedBox1,
                      ValueListenableBuilder(
                        valueListenable: checkInDateNotifier,
                        builder: (context, value, child) => CustomTextFormField(
                          controller: TextEditingController(
                            text: DateFormat(
                              "dd-MM-yyyy hh:mm a",
                            ).format(
                                checkInDateNotifier.value ?? DateTime.now()),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDateTime = await showDateTimePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050),
                            );
                            if (pickedDateTime != null) {
                              checkInDateNotifier.value = pickedDateTime;

                              if (checkInDateNotifier.value != null &&
                                  checkOutDateNotifier.value != null) {
                                Duration? dur = checkOutDateNotifier.value
                                    ?.difference(checkInDateNotifier.value ??
                                        DateTime.now());
                                priceSlotNotifier.value =
                                    ((dur?.inMinutes ?? 0) / 60) * 10;
                              }
                            }
                          },
                        ),
                      ),
                      vSizedBox2andHalf,
                      CustomText.ourText("CheckOut Date"),
                      vSizedBox1,
                      ValueListenableBuilder(
                        valueListenable: checkOutDateNotifier,
                        builder: (context, value, child) => CustomTextFormField(
                          controller: TextEditingController(
                            text: DateFormat(
                              "dd-MM-yyyy hh:mm a",
                            ).format(
                                checkOutDateNotifier.value ?? DateTime.now()),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDateTime = await showDateTimePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050),
                            );
                            if (pickedDateTime != null) {
                              checkOutDateNotifier.value = pickedDateTime;

                              if (checkInDateNotifier.value != null &&
                                  checkOutDateNotifier.value != null) {
                                Duration? dur = checkOutDateNotifier.value
                                    ?.difference(checkInDateNotifier.value ??
                                        DateTime.now());

                                priceSlotNotifier.value =
                                    ((dur?.inMinutes ?? 0) / 60) * 10;
                                consolelog(priceSlotNotifier.value);
                              }
                            }
                          },
                        ),
                      ),
                      vSizedBox2andHalf,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Amount",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: priceSlotNotifier,
                            builder: (context, value, child) => Text(
                              "NPR. ${priceSlotNotifier.value?.toInt() ?? 0}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      vSizedBox2andHalf,
                      ValueListenableBuilder(
                        valueListenable: selectedSlotNotifier,
                        builder: (context, value, child) => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                          ), // background
                          onPressed: selectedSlotNotifier.value == null
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    if (checkInDateNotifier.value == null ||
                                        checkOutDateNotifier.value == null) {
                                      warningToast(
                                          msg:
                                              "Please select checkin and checkout date");
                                    } else if (checkInDateNotifier.value!
                                        .isAfter(checkOutDateNotifier.value!)) {
                                      warningToast(
                                          msg:
                                              "Checkin date should be before checkout date");
                                    } else {
                                      BlocProvider.of<BookSlotCubit>(context)
                                          .bookSlot(
                                        context,
                                        numberPlate: numberr.text,
                                        totalAmt: priceSlotNotifier.value ?? 0,
                                      );
                                      //   KhaltiScope.of(context).pay(
                                      //     config: PaymentConfig(
                                      //       amount: (selectedSlotNotifier.value ?? 0) * 100,
                                      //       productIdentity: numberr.text,
                                      //       productName: "Parking",
                                      //     ),
                                      //     preferences: [PaymentPreference.khalti],
                                      //     onSuccess: (su) {
                                      //       const successsnackBar = SnackBar(
                                      //         content: Text("Payment successful"),
                                      //         backgroundColor: Colors.green,
                                      //       );
                                      //       ScaffoldMessenger.of(context)
                                      //           .showSnackBar(successsnackBar);
                                      //       Navigator.of(context).push(
                                      //         MaterialPageRoute(
                                      //           builder: (context) => QRPage(
                                      //             data: su.productIdentity,
                                      //           ),
                                      //         ),
                                      //       );
                                      //     },
                                      //     onFailure: (fa) {
                                      //       const failedsnackBar = SnackBar(
                                      //         content: Text("payment failed"),
                                      //       );
                                      //       ScaffoldMessenger.of(context)
                                      //           .showSnackBar(failedsnackBar);
                                      //     },
                                      //     onCancel: () {
                                      //       const cancelsnackBar = SnackBar(
                                      //         content: Text("payment cancel"),
                                      //         backgroundColor: Colors.red,
                                      //       );
                                      //       ScaffoldMessenger.of(context)
                                      //           .showSnackBar(cancelsnackBar);
                                      //     },
                                      //   );
                                    }
                                  }
                                },
                          child: const Text(
                            "Book Slots",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
