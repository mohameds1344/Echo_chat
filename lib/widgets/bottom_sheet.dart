import 'package:chat_app/constans.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/view/chat_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/pinCode_text_field.dart';
import 'package:flutter/material.dart';

class BottomSheetVerify extends StatefulWidget {
  const BottomSheetVerify({super.key, required this.authService});

  final AuthService authService;

  @override
  State<BottomSheetVerify> createState() => _BottomSheetVerifyState();
}

class _BottomSheetVerifyState extends State<BottomSheetVerify> {
  String tempPhone = "";
  String tempOTP = "";
  bool isLoading = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  String? errorMessage;
  @override
  @override
  Widget build(BuildContext context) {
    bool hasSendOTP = widget.authService.verificationId != null;
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 20),
            Text(
              hasSendOTP ? "Verify OTP" : "Phone Number",
              style: TextStyle(
                fontSize: 20,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              hasSendOTP
                  ? "Enter the code sent to your device"
                  : "We will send you a one-time password",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            SizedBox(height: 20),
            if (hasSendOTP)
              CustemOtpField(otpController: otpController)
            else
              CustomTextFormField(
                errorText: errorMessage,
                vaildator: (data) {
                  if (errorMessage != null) {
                    return errorMessage;
                  }
                  if (data == null || data.isEmpty) {
                    return 'field is required';
                  }
                 if (!RegExp(r'^\+201[0-9]{9}$').hasMatch(data)) {
                    return 'invalid phone number';
                  }
                  return null;
                },

                controller: phoneController,
                hintText: "+20-123-567-89",
                icon: Icons.phone,
                onChanged: (data) {
                  tempPhone = data;
                },
              ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : CustomButton(
                    title: hasSendOTP ? "Verify" : "Send OTP",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() => isLoading = true);
                        try {
                          if (!hasSendOTP) {
                            await widget.authService.sendOTP(
                              phoneController.text,
                              () {
                                setState(() {});
                              },
                            );
                          } else {
                            await widget.authService.verifyOTP(
                              otpController.text,
                            );
                            Navigator.pushReplacementNamed(
                              context,
                              ChatView.id,
                              arguments: phoneController.text,
                            );
                          }
                        } catch (e) {
                          setState(() {
                            if (e.toString().contains('invalid-phone-number')) {
                              errorMessage = "invalid phone number";
                            } else {
                              errorMessage = "An error occurred, try again";
                            }
                          });
                          formKey.currentState!.validate();
                        }
                        setState(() => isLoading = false);
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
