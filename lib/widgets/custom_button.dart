import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.title,this.onTap});
  String title;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Container(
          height: 50,
          
          decoration: BoxDecoration(
            color: Color(0xFF1E41C1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(
              color: Color(0xFF1E41C1).withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 5)
            )]
          ),
          child: Center(
            child: Text(title, style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          ),
        ),),
      ),
    );
  }
}
