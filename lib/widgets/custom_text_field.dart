import 'package:chat_app/constans.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.icon,
    this.obsureText = false,
    this.controller,
    this.vaildator,
    this.errorText
  });

  String hintText;
  Function(String)? onChanged;
  final IconData? icon;
  final bool obsureText;
  TextEditingController? controller;
  final String? Function(String?)? vaildator;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: controller,
      obscureText: obsureText,
      validator:
          vaildator ??
          (data) {
            if (data == null || data.isEmpty) {
              return 'field is required';
            }
            return null;
          },
      onChanged: onChanged,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        errorText: errorText,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        suffixIcon: icon != null
            ? Icon(icon, color: kPrimaryColor, size: 22)
            : null,

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 1.5),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}
