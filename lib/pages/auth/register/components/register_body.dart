part of '../register_screen.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state.status == RegisterStatus.loading) {
              CustomDialogs.fullLoadingDialog(
                  context: context, data: state.message);
            }
            if (state.status == RegisterStatus.success) {
              back(context);
              successToast(msg: state.message);
              navigate(context, const OtpScreen());
            }
            if (state.status == RegisterStatus.failure) {
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
              navigateOffAll(context, const LoginScreen());
            }
            if (state.status == OtpStatus.failure) {
              back(context);
              errorToast(msg: state.message ?? '');
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: screenPadding,
          child: Column(
            children: [
              // AnimatedContainer(
              //   height:
              //       MediaQuery.of(context).viewInsets.bottom != 0 ? 100 : 120,
              //   duration: const Duration(milliseconds: 350),
              //   child: Image.asset(
              //     kRojgarLogo,
              //   ),
              // ),
              vSizedBox2andHalf,
              CustomText.ourText(
                "Sign Up",
                fontSize: 20,
              ),
              vSizedBox1,
              CustomText.ourText(
                "Let's create an account!",
                fontSize: 16,
                color: RColors.kNeutral600Color,
              ),
              vSizedBox2andHalf,
              Form(
                key: BlocProvider.of<RegisterCubit>(context).registerFormKey,
                child: Column(
                  children: [
                    const RegisterFormWidget(),
                    vSizedBox1,
                    vSizedBox3,
                    CustomButton.elevatedButton(
                      "Sign Up",
                      () async {
                        if (BlocProvider.of<RegisterCubit>(context)
                            .registerFormKey
                            .currentState!
                            .validate()) {
                          unfocusKeyboard(context);
                          BlocProvider.of<RegisterCubit>(context).register();
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
                  text: "Already have an account?",
                  style: const TextStyle(
                    fontSize: 14,
                    color: RColors.kNeutral800Color,
                  ),
                  children: [
                    TextSpan(
                      text: " Sign in",
                      style: const TextStyle(
                        color: RColors.kPrimaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          navigateOffAll(context, const LoginScreen());
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
