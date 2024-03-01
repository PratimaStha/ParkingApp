import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking/core/app/dimensions.dart';
import 'package:flutter_parking/core/development/console.dart';
import 'package:flutter_parking/core/routing/route_navigation.dart';
import 'package:flutter_parking/pages/cubit/book_slot/book_slot_cubit.dart';
import 'package:flutter_parking/pages/style.dart';
import 'package:flutter_parking/widgets/custom_button.dart';
import 'package:flutter_parking/widgets/custom_toast.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_dialogs.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BookSlotCubit, BookSlotState>(
          listener: (context, state) {
            if (state.status == BookSlotStatus.deleteLoading) {
              CustomDialogs.fullLoadingDialog(
                context: context,
                data: state.message,
              );
            }

            if (state.status == BookSlotStatus.deleteFailure) {
              back(context);
              errorToast(msg: state.message ?? "Something went wrong");
            }

            if (state.status == BookSlotStatus.deleteSuccess) {
              back(context);
              successToast(msg: state.message);
              BlocProvider.of<BookSlotCubit>(context).getMyBookSlot(context);
            }
          },
        ),
        BlocListener<BookSlotCubit, BookSlotState>(
          listener: (context, state) {
            if (state.status == BookSlotStatus.updateReservedLoading) {
              CustomDialogs.fullLoadingDialog(
                context: context,
                data: state.message,
              );
            }

            if (state.status == BookSlotStatus.updateReservedFailure) {
              back(context);
              errorToast(msg: state.message ?? "Something went wrong");
            }

            if (state.status == BookSlotStatus.updateReservedSuccess) {
              back(context);
              successToast(msg: state.message);
              BlocProvider.of<BookSlotCubit>(context).getMyBookSlot(context);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Booking History",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: BlocBuilder<BookSlotCubit, BookSlotState>(
          builder: (context, state) {
            if (state.status == BookSlotStatus.getMyBookLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.status == BookSlotStatus.getMyBookFailure) {
              return Center(
                child: Text(state.message ?? "Something went wrong"),
              );
            }
            return state.myBookSlotResponseModel?.bookings?.isEmpty ?? false
                ? const Center(
                    child: Text("Empty"),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<BookSlotCubit>(context)
                          .getMyBookSlot(context);
                      return Future.value();
                    },
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      padding: screenLeftRightPadding,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => vSizedBox1,
                        itemCount:
                            state.myBookSlotResponseModel?.bookings?.length ??
                                0,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: screenLeftRightPadding,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                vSizedBox1,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Spot Number: ${state.myBookSlotResponseModel?.bookings?[index].parkingSpot?.spotNumber ?? ""}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    hSizedBox1,
                                    Text.rich(
                                      TextSpan(
                                        text: "Number Plate: ",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: state
                                                    .myBookSlotResponseModel
                                                    ?.bookings?[index]
                                                    .numberPlate ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                vSizedBox1,
                                Text(
                                  state.myBookSlotResponseModel
                                          ?.bookings?[index].user?.name ??
                                      "",
                                ),
                                vSizedBox1,
                                Text(
                                  state.myBookSlotResponseModel
                                          ?.bookings?[index].user?.email ??
                                      "",
                                ),
                                vSizedBox1,
                                Text(
                                  "NPR. ${state.myBookSlotResponseModel?.bookings?[index].price ?? ""}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                vSizedBox1,
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Timing : ${DateFormat("dd, MMM yyyy hh:mm a").format(DateTime.parse(state.myBookSlotResponseModel?.bookings?[index].startTime ?? "").toLocal())} - ${DateFormat("dd, MMM yyyy hh:mm a").format(DateTime.parse(state.myBookSlotResponseModel?.bookings?[index].endTime ?? "").toLocal())}",
                                  ),
                                ),
                                vSizedBox1,
                                Row(
                                  children: [
                                    state
                                                .myBookSlotResponseModel
                                                ?.bookings?[index]
                                                .parkingSpot
                                                ?.status !=
                                            "reserved"
                                        ? Expanded(
                                            child: CustomButton.elevatedButton(
                                              "Cancel",
                                              () {
                                                if (DateTime.parse(state
                                                            .myBookSlotResponseModel
                                                            ?.bookings?[index]
                                                            .endTime ??
                                                        "")
                                                    .isAfter(DateTime.now())) {
                                                  BlocProvider.of<
                                                              BookSlotCubit>(
                                                          context)
                                                      .deleteBookSlot(context,
                                                          bookingId: state
                                                                  .myBookSlotResponseModel
                                                                  ?.bookings?[
                                                                      index]
                                                                  .id ??
                                                              "");
                                                } else {
                                                  warningToast(
                                                      msg:
                                                          "This slot cannot be cancel.");
                                                }
                                              },
                                              color: Colors.red,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              titleColor: Colors.white,
                                            ),
                                          )
                                        : Container(),
                                    hSizedBox1,
                                    Expanded(
                                      child: CustomButton.elevatedButton(
                                        "Reserved",
                                        state
                                                    .myBookSlotResponseModel
                                                    ?.bookings?[index]
                                                    .parkingSpot
                                                    ?.status !=
                                                "reserved"
                                            ? () {
                                                if (DateTime.parse(state
                                                            .myBookSlotResponseModel
                                                            ?.bookings?[index]
                                                            .endTime ??
                                                        "")
                                                    .isAfter(DateTime.now())) {
                                                  BlocProvider.of<
                                                              BookSlotCubit>(
                                                          context)
                                                      .updateBookingSlot(
                                                          context,
                                                          bookingId: state
                                                                  .myBookSlotResponseModel
                                                                  ?.bookings?[
                                                                      index]
                                                                  .id ??
                                                              "");
                                                } else {
                                                  warningToast(
                                                      msg:
                                                          "This slot cannot be reserved.");
                                                }
                                              }
                                            : () {},
                                        isDisable: state
                                                .myBookSlotResponseModel
                                                ?.bookings?[index]
                                                .parkingSpot
                                                ?.status ==
                                            "reserved",
                                        color: AppColors.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        titleColor: Colors.white,
                                      ),
                                    ),
                                    hSizedBox1,
                                    state
                                                .myBookSlotResponseModel
                                                ?.bookings?[index]
                                                .parkingSpot
                                                ?.status !=
                                            "reserved"
                                        ? Container()
                                        : Expanded(
                                            child: CustomButton.elevatedButton(
                                              "Make Available",
                                              state
                                                          .myBookSlotResponseModel
                                                          ?.bookings?[index]
                                                          .parkingSpot
                                                          ?.status ==
                                                      "reserved"
                                                  ? () {
                                                      BlocProvider.of<
                                                                  BookSlotCubit>(
                                                              context)
                                                          .deleteBookSlot(
                                                              context,
                                                              bookingId: state
                                                                      .myBookSlotResponseModel
                                                                      ?.bookings?[
                                                                          index]
                                                                      .id ??
                                                                  "");
                                                    }
                                                  : () {},
                                              isDisable: state
                                                      .myBookSlotResponseModel
                                                      ?.bookings?[index]
                                                      .parkingSpot
                                                      ?.status !=
                                                  "reserved",
                                              color: AppColors.primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              titleColor: Colors.white,
                                            ),
                                          ),
                                  ],
                                ),
                                vSizedBox1,
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
