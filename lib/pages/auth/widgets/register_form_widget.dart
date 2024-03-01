import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking/widgets/validations.dart';
import '../../../../core/app/dimensions.dart';
import '../../../../core/app/states.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../register/components/cubit/register_cubit.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                validator: (val) {
                  if (val.toString().isEmptyData()) {
                    return "Empty";
                  } else {
                    return null;
                  }
                },
                labelText: "First Name",
                hintText: "Enter your first name",
                fullNameString: true,
                controller: BlocProvider.of<RegisterCubit>(context)
                    .registerFirstNameController,
                autoFillHint: const [],
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.person,
              ),
            ),
            hSizedBox1,
            Expanded(
              child: CustomTextFormField(
                validator: (val) {
                  if (val.toString().isEmptyData()) {
                    return "Empty";
                  } else {
                    return null;
                  }
                },
                labelText: "Last Name",
                hintText: "Enter your last name",
                fullNameString: true,
                controller: BlocProvider.of<RegisterCubit>(context)
                    .registerLastNameController,
                autoFillHint: const [],
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.person,
              ),
            ),
          ],
        ),
        vSizedBox2,
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
          controller:
              BlocProvider.of<RegisterCubit>(context).registerEmailController,
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
            controller: BlocProvider.of<RegisterCubit>(context)
                .registerPasswordController,
            prefixIcon: Icons.lock,
            suffix: IconButton(
              onPressed: () {
                showLoginPassword.value = !showLoginPassword.value;
              },
              icon: showLoginPassword.value
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
            textInputAction: TextInputAction.next,
            obscureText: showLoginPassword.value == false,
          ),
        ),
        vSizedBox2,
        ValueListenableBuilder(
          valueListenable: showLoginPassword,
          builder: (context, value, child) => CustomTextFormField(
            validator: (val) => val.toString().isEmptyData()
                ? "Empty"
                : val.toString().isPasswordLength()
                    ? "Password must be of 6 length characters"
                    : val.toString() !=
                            BlocProvider.of<RegisterCubit>(context)
                                .registerPasswordController
                                .text
                        ? "Password doesnot match"
                        : null,
            labelText: "Confirm Password",
            hintText: "Enter your confirm password",
            controller: BlocProvider.of<RegisterCubit>(context)
                .registerConfirmPasswordController,
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
