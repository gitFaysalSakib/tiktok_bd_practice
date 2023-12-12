import 'package:bdtok_prac/controller/auth_controller.dart';
import 'package:bdtok_prac/view/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:bdtok_prac/constrains.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to \n BdTok', textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            
            
            TextInputWidget(
                myLabelText: "Email",
                myIcon: Icons.person,
                controller: emailController),
            const SizedBox(
              height: 12,
            ),
            TextInputWidget(
                myLabelText: "Password",
                myIcon: Icons.person,
                controller: passwordController),
            const SizedBox(
              height: 12,
            ),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 40),
              child: ElevatedButton(
                onPressed: () {
                  AuthController.instance.loginMethod(emailController.text, passwordController.text);
                },
                child: const Text('Login'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
