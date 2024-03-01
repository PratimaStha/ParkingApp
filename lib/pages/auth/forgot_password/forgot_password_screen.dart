import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking/pages/auth/forgot_password/components/cubit/forgot_password_cubit.dart';
import 'package:flutter_parking/widgets/validations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/app/states.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/custom_toast.dart';
import '../../../core/app/colors.dart';
import '../../../core/app/dimensions.dart';
import '../../../core/app/medias.dart';
import '../../../core/routing/route_navigation.dart';
import '../../../widgets/custom_dialogs.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/unfocus_keyboard.dart';
import '../otp/components/cubit/otp_cubit.dart';
import '../otp/otp_screen.dart';

part './components/forgot_password_body.dart';
part './components/reset_password_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ForgotPasswordBody();
  }
}
