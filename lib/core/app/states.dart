import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//login
ValueNotifier<bool> showLoginPassword = ValueNotifier<bool>(false);

ValueNotifier<int?> selectedSlotNotifier = ValueNotifier<int?>(null);
ValueNotifier<double?> priceSlotNotifier = ValueNotifier<double?>(null);
ValueNotifier<DateTime?> checkInDateNotifier = ValueNotifier<DateTime?>(null);
ValueNotifier<DateTime?> checkOutDateNotifier = ValueNotifier<DateTime?>(null);
