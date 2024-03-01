import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking/core/development/console.dart';
import 'package:flutter_parking/pages/booking_history.dart';
import 'package:flutter_parking/pages/cubit/my_profile/my_profile_cubit.dart';
import 'package:flutter_parking/pages/profile_screen.dart';
import 'package:flutter_parking/pages/style.dart';
import 'package:flutter_parking/secure_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../models/location.model.dart';
import 'booked.dart';
import 'cubit/book_slot/book_slot_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bottomindex = 0;

  @override
  Widget build(BuildContext context) {
    consolelog(SharedPref.getToken());

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GNav(
        backgroundColor: Colors.white,
        color: Colors.black,
        tabBackgroundColor: AppColors.primaryColor,
        activeColor: Colors.white,
        gap: 10,
        padding: const EdgeInsets.all(16),
        tabMargin: const EdgeInsets.all(8),
        onTabChange: (index) {
          setState(() {
            bottomindex = index;
          });
          index == 1
              ? BlocProvider.of<BookSlotCubit>(context).getMyBookSlot(context)
              : index == 2
                  ? BlocProvider.of<MyProfileCubit>(context)
                      .getMyProfile(context)
                  : null;
        },
        tabs: const [
          GButton(icon: Icons.location_on, text: 'Parking Area'),
          GButton(icon: Icons.bookmark_added, text: 'Booked History'),
          GButton(icon: Icons.man_2_rounded, text: 'Profile'),
        ],
      ),
      body: IndexedStack(
        index: bottomindex,
        children: const [
          ParkingArea(),
          BookingHistory(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
