import 'package:chat_app/constans.dart';
import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key,required this.onGoogleTap,required this.onPhoneTap});

  final VoidCallback onGoogleTap, onPhoneTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      buildIccon(
        iconPath:"assets/icons/google.png" , 
        onTap: onGoogleTap,
      ),
      SizedBox(width: 10,),
      buildIccon(
        iconPath:"assets/icons/phone-call.png" , 
        onTap: onPhoneTap,
        color: kPrimaryColor)

      ],
    );
  }

  Widget buildIccon({
    required String iconPath,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(iconPath, height: 25, color: color),
      ),
    );
  }
}
