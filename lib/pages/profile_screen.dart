import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking/core/routing/route_navigation.dart';
import 'package:flutter_parking/pages/auth/login/login_screen.dart';
import 'package:flutter_parking/pages/cubit/book_slot/book_slot_cubit.dart';
import 'package:flutter_parking/pages/cubit/my_profile/my_profile_cubit.dart';
import 'package:flutter_parking/pages/style.dart';
import 'package:flutter_parking/secure_storage.dart';
import 'package:flutter_parking/widgets/custom_button.dart';
import 'package:flutter_parking/widgets/custom_toast.dart';

import '../core/app/dimensions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: BlocBuilder<MyProfileCubit, MyProfileState>(
        builder: (context, state) {
          if (state.status == MyProfileStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == MyProfileStatus.failure) {
            return Center(
              child: Text(state.message ?? "Something went wrong"),
            );
          }

          return Container(
            padding: screenLeftRightPadding,
            child: Column(
              children: [
                vSizedBox2,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name : ${state.userProfile?.name?.toUpperCase() ?? ""}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      vSizedBox2,
                      Text(
                        "Email : ${state.userProfile?.email ?? ""}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      vSizedBox2,
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton.elevatedButton(
                    "Logout",
                    () {
                      SharedPref.resetCredentials();
                      navigateOffAll(context, const LoginScreen());
                      successToast(msg: "Logout successfully");
                    },
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    titleColor: Colors.white,
                    borderRadius: 16,
                    color: Colors.red,
                  ),
                ),
                vSizedBox2,
              ],
            ),
          );
        },
      ),
    );
  }
}
