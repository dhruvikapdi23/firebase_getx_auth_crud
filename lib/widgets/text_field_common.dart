

import 'package:firebase_getx_auth_crud/utils/common_app_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/theme_service.dart';

class TextFieldCommon extends StatelessWidget {
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon, prefixIcon;
  final Color? fillColor;
  final bool obscureText;
  final bool autoFocus;
  final double? vertical;
  final InputBorder? border;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final int? maxLength,minLines,maxLines;
  final String? counterText;
  final bool readOnly ;

  const TextFieldCommon(
      {super.key,
      required this.hintText,
      this.validator,
      this.controller,
      this.suffixIcon,
      this.prefixIcon,
      this.border,
      this.obscureText = false,
      this.autoFocus = false,
      this.fillColor,
        this.vertical,
      this.keyboardType,
      this.focusNode,
      this.onChanged,
      this.maxLength,this.minLines, this.maxLines,this.counterText, this.readOnly=false});

  @override
  Widget build(BuildContext context) {
    // Text field common
    return TextFormField(
      maxLines: maxLines ?? 1,
      style: AppCommonLayout().poppinsTextStyle(color:appTheme.greyText),autofocus: autoFocus,
      focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        onChanged: onChanged,
        minLines: minLines,
        maxLength: maxLength,readOnly:readOnly ,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          counterText: counterText,
            fillColor: fillColor ?? appTheme.greyText.withValues(alpha:0.05),
            filled: true,
            isDense: true,

            disabledBorder: OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(width: 1, color: appTheme.greyText.withValues(alpha: .30))
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(width: 1, color: appTheme.greyText.withValues(alpha: .30))
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(width: 1, color: appTheme.greyText.withValues(alpha: .30))
            ),
            border:
                 OutlineInputBorder(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(width: 1, color: appTheme.greyText.withValues(alpha: .30))),
            contentPadding:  EdgeInsets.symmetric(
                horizontal: 15, vertical: vertical ?? 17),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintStyle: AppCommonLayout().poppinsTextStyle(color:appTheme.greyText),
            hintText: hintText.tr));
  }
}
