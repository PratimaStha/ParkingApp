import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app/colors.dart';
import '../core/configs/regex_config.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.controller,
    this.onTap,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.readOnly = false,
    this.isFromSearch = false,
    this.suffix,
    this.obscureText = false,
    this.validator,
    this.onlyNumber = false,
    this.onlyText = false,
    this.isEnabled = true,
    this.filled = false,
    this.fillColor = const Color(0xffF4F4F4),
    this.maxLine = 1,
    this.minLine = 1,
    this.maxLength,
    this.prefixText,
    this.prefixIcon,
    this.autovalidateMode,
    this.autoFocus = false,
    this.initialValue,
    this.autoFillHint = const [],
    this.textInputType = TextInputType.text,
    this.textInputAction,
    this.fullNameString = false,
    this.searchString = false,
    this.borderRadius = 8,
    this.prefix,
  }) : super(key: key);
  TextEditingController? controller;
  String? hintText;
  TextInputType textInputType;
  String? labelText;
  Widget? suffix;
  bool? isEnabled;
  bool readOnly;
  bool obscureText;
  final Function? validator;
  bool onlyText;
  bool onlyNumber;
  int? maxLine;
  int? minLine;
  int? maxLength;
  bool? prefixText;
  bool? filled;
  Color? fillColor;
  IconData? prefixIcon;
  Function()? onTap;
  Function? onChanged;
  String? initialValue;
  bool? isFromSearch;
  bool? autoFocus;
  AutovalidateMode? autovalidateMode;
  List<String> autoFillHint;
  bool searchString;
  bool fullNameString;
  TextInputAction? textInputAction;
  double borderRadius;
  Widget? prefix;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLine,
      maxLines: maxLine,
      maxLength: maxLength,
      textInputAction: textInputAction,
      autofillHints: autoFillHint,
      autofocus: autoFocus ?? false,
      validator: (value) {
        return validator == null ? null : validator!(value);
      },
      style: TextStyle(
        color: readOnly ? Colors.black : null,
      ),
      inputFormatters: onlyNumber
          ? [
              FilteringTextInputFormatter.allow(RegexConfig.numberRegex),
            ]
          : onlyText
              ? [
                  FilteringTextInputFormatter.allow(RegexConfig.textRegex),
                ]
              : searchString
                  ? [
                      FilteringTextInputFormatter.allow(
                          RegexConfig.searchRegrex)
                    ]
                  : fullNameString
                      ? [
                          FilteringTextInputFormatter.allow(
                              RegexConfig.fullNameTextRegrex)
                        ]
                      : [],
      readOnly: readOnly,
      initialValue: initialValue,
      enabled: isEnabled,
      onTap: onTap,
      onChanged: (val) => isFromSearch == true ? onChanged!(val) : null,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixText: prefixText == true ? "\$ " : null,
        filled: filled,
        hintStyle: const TextStyle(
          fontFamily: "Outfit",
          color: RColors.kNeutral500Color,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: const TextStyle(
          fontFamily: "Outfit",
          fontSize: 16,
          color: RColors.kNeutral600Color,
        ),
        errorStyle: const TextStyle(
          fontSize: 10.0,
        ),
        prefix: prefix,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.grey,
              )
            : null,
        fillColor: filled == true ? fillColor : null,
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffix,
        enabledBorder: filled == true
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(
                  color: RColors.kTextFormFieldBorderColor,
                ),
              ),
        border: filled == true
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(
                  color: RColors.kTextFormFieldBorderColor,
                ),
              ),
        focusedBorder: filled == true
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(
                  color: RColors.kPrimaryColor,
                ),
              ),
      ),
    );
  }
}
