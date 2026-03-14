import 'package:chat_app/constans.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustemOtpField extends StatelessWidget {
  const CustemOtpField({super.key,required this.otpController});

  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context, 
      length: 6,
      controller:otpController ,
      keyboardType:TextInputType.number,
      animationType: AnimationType.scale,
      cursorColor: kPrimaryColor,

      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 50,
        fieldWidth: 40,
        
        activeFillColor: Colors.white,
        activeColor: kPrimaryColor,

        inactiveFillColor: Color(0xffF2F3F5),
        inactiveColor: Colors.grey[300],

        selectedFillColor: Colors.white,
        selectedColor: kPrimaryColor,

      ),
      animationDuration: Duration(microseconds: 300),
      enableActiveFill: true,
      onChanged: (value){},
      );
  }
}
