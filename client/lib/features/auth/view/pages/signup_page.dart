import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

List<String> placeholder = ["Name", "Email", "Password"];

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Sign Up",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 25),
            CustomField(hintText: "Name"),
            SizedBox(height: 10),
            CustomField(hintText: "Email"),
            SizedBox(height: 10),
            CustomField(hintText: "Password"),
            SizedBox(height: 10),
            Container(height: 50, width: 50, child: Text("Sign Up")),
          ],
        ),
      ),
    );
  }
}
