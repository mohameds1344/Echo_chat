import 'package:chat_app/common/show_snack_bar.dart';
import 'package:chat_app/constans.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/view/chat_view.dart';
import 'package:chat_app/view/login_view.dart';
import 'package:chat_app/widgets/bottom_sheet.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/social_login_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = 'registerView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email, password, fullName;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor:Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  Positioned(
                    top: -160,
                    right: -60,
                    child: _buildBlob(kPrimaryColor.withOpacity(0.4)),
                  ),
                  Positioned(
                    top: -60,
                    right: -85,
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: _buildBlob(kPrimaryColor.withOpacity(0.4)),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 150),
                      const Center(
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            color: kPrimaryColor,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Center(
                        child: Text(
                          "Join the Echo community and \n amplify your voice",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomTextFormField(
                      onChanged: (data) => fullName = data,
                      hintText: "Full Name",
                      icon: Icons.person_outline_rounded,
                    ),
                    CustomTextFormField(
                      onChanged: (data) => email = data,
                      hintText: "Email",
                      icon: Icons.alternate_email_rounded,
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      onChanged: (data) => password = data,
                      hintText: "Password",
                      icon: Icons.lock_outline_rounded,
                      obsureText: true,
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() => isLoading = true);
                          try {
                            await authService.registerUser(email!, password!);
                            await FirebaseAuth.instance.currentUser
                                ?.updateDisplayName(fullName);
                            Navigator.pushReplacementNamed(
                              context,
                              ChatView.id,
                              arguments: email,
                            );
                          } on FirebaseAuthException catch (ex) {
                            showSnackBar(context, ex.code);
                          } catch (ex) {
                            showSnackBar(context, "There was an error");
                          }
                          setState(() => isLoading = false);
                        }
                      },
                      title: "Register",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Or continue with",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 25),
              SocialLoginButtons(
                onGoogleTap: () async {
                  setState(() => isLoading = true);
                  try {
                    UserCredential? userCredential = await authService
                        .signInWithGoogle();
                    if (userCredential != null) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        ChatView.id,
                        (route) => false,
                        arguments: userCredential.user!.email,
                      );
                    }
                  } catch (e) {
                    showSnackBar(context, "Google Sign-In failed");
                  }
                  setState(() => isLoading = false);
                },
                onPhoneTap: () {
                  _showPhoneAuthSheet(context);
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "already have an account?",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginView.id,
                      (route) => route.isFirst,
                    ),
                    child: const Text(
                      " Login",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showPhoneAuthSheet(BuildContext context) {
    String tempPhone = "";
    String tempOTP = "";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => BottomSheetVerify(authService: authService),
    );
  }

  Widget _buildBlob(Color color) {
    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
        ],
      ),
    );
  }
}
