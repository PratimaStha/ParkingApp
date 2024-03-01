part of '../login_screen.dart';

class LoginBody extends StatelessWidget {
  LoginBody({super.key});

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.loading) {
          CustomDialogs.fullLoadingDialog(
              context: context, data: state.message);
        }
        if (state.status == LoginStatus.success) {
          back(context);
          navigateOffAll(context, const HomePage());
          successToast(msg: state.message);
        }
        if (state.status == LoginStatus.failure) {
          back(context);
          errorToast(msg: state.message ?? '');
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: screenPadding,
          child: Column(
            children: [
              vSizedBox2andHalf,
              vSizedBox2andHalf,
              // AnimatedContainer(
              //   height: MediaQuery.of(context).viewInsets.bottom != 0 ? 100 : 120,
              //   duration: const Duration(milliseconds: 350),
              //   child: Image.asset(
              //     kRojgarLogo,
              //   ),
              // ),
              vSizedBox2andHalf,
              CustomText.ourText(
                "Sign In",
                fontSize: 20,
              ),
              vSizedBox1,
              CustomText.ourText(
                "We've already met!",
                fontSize: 16,
                color: RColors.kNeutral600Color,
              ),
              vSizedBox2andHalf,
              Form(
                key: loginFormKey,
                child: Column(
                  children: [
                    const LoginFormWidget(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          navigate(context, const ForgotPasswordScreen());
                        },
                        child: CustomText.ourText(
                          "Forgot password",
                          fontSize: 13,
                          color: RColors.kPrimaryColor,
                        ),
                      ),
                    ),
                    vSizedBox3,
                    CustomButton.elevatedButton(
                      "Sign In",
                      () async {
                        if (loginFormKey.currentState!.validate()) {
                          unfocusKeyboard(context);
                          BlocProvider.of<LoginCubit>(context).login(context);
                        } else {
                          errorToast(
                            msg: "Please fill",
                          );
                        }
                      },
                      borderRadius: 16.0,
                      width: 250,
                      height: 50,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
              vSizedBox2,
              Text.rich(
                TextSpan(
                  text: "Don't have an account?",
                  style: const TextStyle(
                    fontSize: 14,
                    color: RColors.kNeutral800Color,
                  ),
                  children: [
                    TextSpan(
                      text: " Sign up",
                      style: const TextStyle(
                        color: RColors.kPrimaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          navigate(context, const RegisterScreen());
                        },
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
