import 'package:chat_app/authentication/auth_services.dart';
import 'package:chat_app/components/common_button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conformPasswordController =
      TextEditingController();
  final void Function()? onTap;
  Register({super.key, required this.onTap});

  void register(BuildContext context) {
    // ger auth instance and register
    final auth = AuthService();
    // check if password and conform password are the same
    if (_passwordController.text == _conformPasswordController.text) {
      try {
        auth.signUpWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'))
                  ],
                ));
      }
    }
    //if password and conform password are not the same
    else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('Passwords do not match'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text('Register'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.message,
                  size: 60, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 20),
              Text("Create an account",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.inversePrimary)),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: _passwordController,
              ),
              MyTextField(
                hintText: "Conform Password",
                obscureText: true,
                controller: _conformPasswordController,
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                  text: "Register",
                  onTap: () {
                    register(context);
                    print("Trying to Register");
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already a member?',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 15)),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(' Login here',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 15)),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
