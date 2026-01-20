import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/repository/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' hide State;

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
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
                  ref
                      .read(authViewModelProvider.notifier)
                      .signUpUser(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
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
