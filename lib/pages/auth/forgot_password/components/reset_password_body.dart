part of '../forgot_password_screen.dart';

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: screenLeftRightPadding,
        child: Column(
          children: [
            vSizedBox1,
            Image.asset(
              kResetPasswordGif,
              height: 300,
            ),
            vSizedBox2,
            CustomText.ourText(
              "Reset Password",
              color: RColors.kNeutral800Color,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            vSizedBox1,
            CustomText.ourText(
              "Set the new password for your account so you can login and access all the features of your account",
              color: RColors.kNeutral600Color,
              fontSize: 16,
              textAlign: TextAlign.center,
              maxLines: 5,
            ),
            vSizedBox2andHalf,
            Container(
              padding: screenPadding,
              decoration: BoxDecoration(
                color: RColors.kNeutral50Color,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Form(
                      key: BlocProvider.of<ForgotPasswordCubit>(context)
                          .resetPasswordFormKey,
                      child: Column(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: showLoginPassword,
                            builder: (context, value, child) =>
                                CustomTextFormField(
                              validator: (val) => val.toString().isEmptyData()
                                  ? "Empty"
                                  : val.toString().isPasswordLength()
                                      ? "Password must be of 6 length characters"
                                      : null,
                              labelText: "Password",
                              hintText: "Enter your password",
                              controller:
                                  BlocProvider.of<ForgotPasswordCubit>(context)
                                      .forgotPasswordController,
                              prefixIcon: Icons.lock,
                              suffix: IconButton(
                                onPressed: () {
                                  showLoginPassword.value =
                                      !showLoginPassword.value;
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
                            builder: (context, value, child) =>
                                CustomTextFormField(
                              validator: (val) => val.toString().isEmptyData()
                                  ? "Empty"
                                  : val.toString().isPasswordLength()
                                      ? "Password must be of 6 length characters"
                                      : val.toString() !=
                                              BlocProvider.of<
                                                          ForgotPasswordCubit>(
                                                      context)
                                                  .forgotPasswordController
                                                  .text
                                          ? "Password doesnot match"
                                          : null,
                              labelText: "Confirm Password",
                              hintText: "Enter your confirm password",
                              controller:
                                  BlocProvider.of<ForgotPasswordCubit>(context)
                                      .forgotConfirmPasswordController,
                              prefixIcon: Icons.lock,
                              suffix: IconButton(
                                onPressed: () {
                                  showLoginPassword.value =
                                      !showLoginPassword.value;
                                },
                                icon: showLoginPassword.value
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                              ),
                              obscureText: showLoginPassword.value == false,
                            ),
                          ),
                        ],
                      )),
                  vSizedBox2andHalf,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText.ourText(
                        "Send",
                        color: RColors.kNeutral800Color,
                        fontSize: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (BlocProvider.of<ForgotPasswordCubit>(context)
                                  .resetPasswordFormKey
                                  .currentState
                                  ?.validate() ??
                              false) {
                            unfocusKeyboard(context);
                            // login(isFromLogin: false);
                          } else {
                            errorToast(msg: "Fill the required field");
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                RColors.kPrimaryColor,
                                RColors.kPrimaryGradientEndColor,
                              ],
                            ),
                          ),
                          width: 80,
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            vSizedBox2,
          ],
        ),
      ),
    );
  }
}
