// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking/pages/auth/otp/components/cubit/otp_cubit.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/app/dimensions.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_toast.dart';
import '../../../core/app/colors.dart';
import '../../../core/app/states.dart';
import '../../../core/configs/regex_config.dart';
import '../register/components/cubit/register_cubit.dart';

part './components/otp_body.dart';

class OtpScreen extends StatelessWidget {
  final bool? isFromRegister;
  const OtpScreen({
    Key? key,
    this.isFromRegister = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OtpBody(
      isFromRegister: isFromRegister,
    );
  }
}
