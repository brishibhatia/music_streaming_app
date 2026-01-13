import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/repository/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  List<String> placeholder = ["Name", "Email", "Password"];
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    // formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Form(
          key: formKey,
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
              CustomField(hintText: "Name", controller: nameController),
              SizedBox(height: 10),
              CustomField(hintText: "Email", controller: emailController),
              SizedBox(height: 10),
              CustomField(
                hintText: "Password",
                controller: passwordController,
                isObscureText: true,
              ),
              SizedBox(height: 10),
              AuthGradientButton(
                buttonText: 'Sign Up',
                onTap: () async {
                  try {
                    final res = await AuthRemoteRepository().signup(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    final val = switch (res) {
                      Left(value: final l) => l,
                      Right(value: final r) => r.toString(),
                    };
                    print(val);
                  } catch (e) {
                    print("Signup failed: $e");
                  }
                },
              ),

              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account ?"),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Pallete.gradient2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
