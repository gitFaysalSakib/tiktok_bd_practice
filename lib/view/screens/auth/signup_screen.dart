// ignore_for_file: unused_import

import 'package:bdtok_prac/controller/auth_controller.dart';
import 'package:bdtok_prac/view/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:bdtok_prac/constrains.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  SignupScreen({super.key});

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
              'Welcome to BdTok',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                AuthController.instance.selectPropic();
              },
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/768px-User-avatar.svg.png'),
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        child: const Icon(
                          Icons.edit,
                          size: 20,
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextInputWidget(
                myLabelText: "Username",
                myIcon: Icons.person,
                controller: usernameController),
            const SizedBox(
              height: 12,
            ),
            TextInputWidget(
                myLabelText: "Email",
                myIcon: Icons.email,
                controller: emailController),
            const SizedBox(
              height: 12,
            ),
            TextInputWidget(
              isHide: true,
                myLabelText: "Password",
                myIcon: Icons.lock,
                controller: passwordController),
            const SizedBox(
              height: 12,
            ),
            TextInputWidget(
              isHide: true,
                myLabelText: "Confirm Password",
                myIcon: Icons.lock,
                controller: confirmPasswordController),
            const SizedBox(
              height: 12,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 40),
              child: ElevatedButton(
                onPressed: () {
                  AuthController.instance.signup(
                      usernameController.text,
                      emailController.text,
                      AuthController.instance.proPic,
                      passwordController.text);
                },
                child: const Text('Sign Up'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
