// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../otp_screen.dart';

class OtpBody extends StatelessWidget {
  final bool? isFromRegister;
  OtpBody({
    Key? key,
    this.isFromRegister = true,
  }) : super(key: key);

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: screenLeftRightPadding,
        child: Column(
          children: [
            vSizedBox4,
            CustomText.ourText(
              "OTP Code",
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: RColors.kNeutral800Color,
            ),
            vSizedBox2,
            // CustomText.ourText(
            //   "Otp has been sent to your email ${isFromRegister ?? false ? BlocProvider.of<RegisterCubit>(context).registerEmailController.text.trim() : forgotEmailController.text.trim()}",
            //   fontSize: 14.0,
            //   maxLines: 4,
            //   textAlign: TextAlign.center,
            // ),
            vSizedBox2,
            vSizedBox2,
            Form(
              key: BlocProvider.of<OtpCubit>(context).pinputFormKey,
              child: Directionality(
                // Specify direction if desired
                textDirection: TextDirection.ltr,
                child: Pinput(
                  autofocus: true,
                  enableSuggestions: true,
                  controller: BlocProvider.of<OtpCubit>(context)
                      .pinputEditingController,
                  focusNode: focusNode,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  validator: (value) {
                    return value?.isNotEmpty ?? false ? null : 'Fill the pin';
                  },
                  // onClipboardFound: (value) {
                  //   debugPrint('onClipboardFound: $value');
                  //   pinController.setText(value);
                  // },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    debugPrint('onCompleted: $pin');
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: focusedBorderColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: RColors.kPrimaryColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: RColors.kBrandPrimaryColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegexConfig.numberRegex)
                  ],
                ),
              ),
            ),
            vSizedBox4,
            CustomButton.elevatedButton(
              "Verify",
              () {
                if (BlocProvider.of<OtpCubit>(context)
                        .pinputFormKey
                        .currentState
                        ?.validate() ??
                    false) {
                  BlocProvider.of<OtpCubit>(context)
                      .otpVerify(context, isFromRegister: isFromRegister);
                } else {
                  errorToast(msg: "Fill the otp");
                }
              },
              borderRadius: 12,
              fontSize: 16,
              height: 50,
              width: 250,
            ),
          ],
        ),
      ),
    );
  }
}
