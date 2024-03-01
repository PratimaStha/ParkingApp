import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_parking/app_bloc_observer.dart';
import 'package:flutter_parking/pages/auth/forgot_password/components/cubit/forgot_password_cubit.dart';
import 'package:flutter_parking/pages/auth/otp/components/cubit/otp_cubit.dart';
import 'package:flutter_parking/pages/auth/register/components/cubit/register_cubit.dart';
import 'package:flutter_parking/pages/cubit/book_slot/book_slot_cubit.dart';
import 'package:flutter_parking/pages/cubit/my_profile/my_profile_cubit.dart';
import 'package:flutter_parking/pages/loginpage.dart';
import 'package:flutter_parking/pages/splash_screen.dart';
import 'package:flutter_parking/secure_storage.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:khalti_flutter/localization/khalti_localizations.dart';

import 'core/app/colors.dart';
import 'pages/auth/login/components/cubit/login_cubit.dart';
import 'pages/auth/login/login_screen.dart';
import 'widgets/get_swatch_color.dart';

//import 'package:flutter_parking/pages/khalti.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  SharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginCubit(),
        ),
        BlocProvider(
          create: (_) => RegisterCubit(),
        ),
        BlocProvider(
          create: (_) => OtpCubit(),
        ),
        BlocProvider(
          create: (_) => ForgotPasswordCubit(),
        ),
        BlocProvider(
          create: (_) => BookSlotCubit(),
        ),
        BlocProvider(
          create: (_) => MyProfileCubit(),
        ),
      ],
      child: KhaltiScope(
          publicKey: "test_public_key_b857754ab7d949aa97ce19b95129a54f",
          builder: (context, navigatorkey) {
            return MaterialApp(
              navigatorKey: navigatorkey,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              //  themeMode: useLightMode ? ThemeMode.light:ThemeData.dark,
              theme: ThemeData(
                useMaterial3: true,
                appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: RColors.kPrimaryColor,
                    statusBarBrightness: Brightness.light,
                  ),
                  backgroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.white,
                  elevation: 0,
                ),
                dialogTheme: const DialogTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  surfaceTintColor: Colors.white,
                ),
                tabBarTheme: TabBarTheme(
                  labelStyle: const TextStyle(
                    color: RColors.kNeutral800Color,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Outfit',
                    fontSize: 18,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    color: RColors.kNeutral800Color,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    fontFamily: 'Outfit',
                  ),
                  overlayColor:
                      MaterialStateProperty.all(RColors.kLightPrimaryColor),
                  indicatorColor: RColors.kBrandPrimaryColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: RColors.kNeutral800Color,
                  labelColor: RColors.kBrandPrimaryColor,
                ),
                primaryColorLight: RColors.kBrandPrimaryColor,
                // primarySwatch: MaterialColor(
                //     0xff0D0D0D, getSwatchColor(const Color(0xff0D0D0D))),
                primaryColor: RColors.kPrimaryColor,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: MaterialColor(
                      0xff0D0D0D, getSwatchColor(const Color(0xff0D0D0D))),
                  outline: RColors.kSecondaryBorderColor,
                  primary: RColors.kPrimaryColor,
                  secondary: RColors.kBrandPrimaryColor,
                  // primarySwatch: MaterialColor(
                  //     0xff09BE8B, getSwatchColor(const Color(0xff09BE8B))),
                  background: Colors.white,
                  error: Colors.red,
                ),
                drawerTheme: const DrawerThemeData(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  endShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                ),
                dialogBackgroundColor: Colors.transparent,
                fontFamily: "Outfit",
                brightness: Theme.of(context).brightness,
                disabledColor: Colors.grey.shade400,
                scaffoldBackgroundColor: RColors.kScaffoldBackgroundColor,
                splashColor: RColors.kLightPrimaryColor,
                highlightColor: RColors.kBrandPrimaryColor.withOpacity(0.5),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    elevation: 0,
                    foregroundColor: RColors.kBrandPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBackgroundColor: Colors.grey.shade400,
                    disabledIconColor: Colors.grey.shade300,
                    disabledForegroundColor: Colors.grey.shade300,
                    shadowColor: Colors.transparent,
                  ),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RColors.kBrandPrimaryColor,
                    elevation: 0,
                    foregroundColor: RColors.kBrandPrimaryColor,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              home: const SplashScreen(),
            );
          }),
    );
  }
}
