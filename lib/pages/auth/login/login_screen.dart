import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking/core/app/states.dart';
import 'package:flutter_parking/pages/auth/login/components/cubit/login_cubit.dart';
import 'package:flutter_parking/pages/homepage.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/app/colors.dart';
import '../../../../../core/routing/route_navigation.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_toast.dart';
import '../../../core/app/dimensions.dart';
import '../../../widgets/custom_dialogs.dart';
import '../../../widgets/unfocus_keyboard.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../register/register_screen.dart';
import '../widgets/login_form_widget.dart';

part './components/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginBody();
  }
}
