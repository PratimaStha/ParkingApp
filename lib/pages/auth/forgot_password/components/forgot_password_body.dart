part of '../forgot_password_screen.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state.status == ForgotPasswordStatus.loading) {
              CustomDialogs.fullLoadingDialog(
                  context: context, data: state.message);
            }
            if (state.status == ForgotPasswordStatus.success) {
              back(context);
              navigate(
                  context,
                  const OtpScreen(
                    isFromRegister: false,
                  ));
              successToast(msg: state.message);
            }
            if (state.status == ForgotPasswordStatus.failure) {
              back(context);
              errorToast(msg: state.message ?? '');
            }
          },
        ),
        BlocListener<OtpCubit, OtpState>(
          listener: (context, state) {
            if (state.status == OtpStatus.loading) {
              CustomDialogs.fullLoadingDialog(
                  context: context, data: state.message);
            }
            if (state.status == OtpStatus.success) {
              back(context);
              successToast(msg: state.message);
              navigate(context, const ResetPasswordBody());
            }
            if (state.status == OtpStatus.failure) {
              back(context);
              errorToast(msg: state.message ?? '');
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: screenLeftRightPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              vSizedBox1,
              SvgPicture.asset(
                kForgotPasswordSvg,
                height: 300,
              ),
              vSizedBox2,
              CustomText.ourText(
                "Forgot Password?",
                color: RColors.kNeutral800Color,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              vSizedBox1,
              CustomText.ourText(
                "Enter the email address associated with your account.",
                color: RColors.kNeutral600Color,
                fontSize: 16,
                textAlign: TextAlign.center,
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
                          .forgotPasswordFormKey,
                      child: CustomTextFormField(
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
                            BlocProvider.of<ForgotPasswordCubit>(context)
                                .forgotEmailController,
                        autoFillHint: const [],
                        textInputAction: TextInputAction.done,
                        prefixIcon: Icons.email,
                      ),
                    ),
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
                                    .forgotPasswordFormKey
                                    .currentState
                                    ?.validate() ??
                                false) {
                              unfocusKeyboard(context);
                              BlocProvider.of<ForgotPasswordCubit>(context)
                                  .forgotPassword(context);
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
      ),
    );
  }
}
