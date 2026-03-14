import 'package:chat_app/constans.dart';
import 'package:chat_app/view/login_view.dart';
import 'package:chat_app/view/register_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});
  static String id = 'InitialPage';

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/photo.png"), context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/photo.png",
              height: 290,

              fit: BoxFit.contain,
            ),
            SizedBox(height: 40),
            Text(
              "Echo app",
              style: TextStyle(
                color: Color(0xFF1E41C1),
                fontSize: 32,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Your voice, amplified. Connect with anyone, anywhere, instantly.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
                height: 1.5,
              ),
            ),
            SizedBox(height: 50),
            CustomButton(
              onTap: () => Navigator.pushNamed(context, RegisterView.id),
              title: "Join Now",
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginView.id);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xFF1E41C1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
