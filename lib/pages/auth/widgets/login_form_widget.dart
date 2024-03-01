import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking/pages/auth/login/components/cubit/login_cubit.dart';
import 'package:flutter_parking/widgets/validations.dart';
import '../../../../core/app/dimensions.dart';
import '../../../../core/app/states.dart';
import '../../../widgets/custom_text_form_field.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          validator: (val) {
            if (val.toString().isEmptyData()) {
              return "Empty";
            } else if (!(val.toString().isValidEmail()) &&
                !(val.toString().isValidPhoneNumber())) {
              return "Email must be valid";
            } else {
              return null;
            }
          },
          textInputType: TextInputType.emailAddress,
          labelText: "Email",
          hintText: "Enter your email",
          controller: BlocProvider.of<LoginCubit>(context)
              .loginEmailOrPhoneNumberController,
          autoFillHint: const [],
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.email,
        ),
        vSizedBox2,
        ValueListenableBuilder(
          valueListenable: showLoginPassword,
          builder: (context, value, child) => CustomTextFormField(
            validator: (val) => val.toString().isEmptyData()
                ? "Empty"
                : val.toString().isPasswordLength()
                    ? "Password must be of 6 length characters"
                    : null,
            labelText: "Password",
            hintText: "Enter your password",
            controller:
                BlocProvider.of<LoginCubit>(context).loginPasswordController,
            prefixIcon: Icons.lock,
            suffix: IconButton(
              onPressed: () {
                showLoginPassword.value = !showLoginPassword.value;
              },
              icon: showLoginPassword.value
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
            obscureText: showLoginPassword.value == false,
          ),
        ),
      ],
    );
  }
}
