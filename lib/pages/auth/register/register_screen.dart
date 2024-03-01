import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking/pages/auth/register/components/cubit/register_cubit.dart';

import '../../../../../core/app/colors.dart';
import '../../../../../core/app/dimensions.dart';
import '../../../../../core/app/medias.dart';
import '../../../../../core/routing/route_navigation.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_toast.dart';

import '../../../core/app/states.dart';
import '../../../widgets/custom_dialogs.dart';
import '../../../widgets/unfocus_keyboard.dart';
import '../login/login_screen.dart';
import '../otp/components/cubit/otp_cubit.dart';
import '../otp/otp_screen.dart';
import '../widgets/register_form_widget.dart';

part './components/register_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const RegisterBody();
  }
}
