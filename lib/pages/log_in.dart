import 'package:chat_app/authentication/auth_services.dart';
import 'package:chat_app/components/common_button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;
  LogIn({super.key, required this.onTap});

  Future<void> logIn(BuildContext context) async {
    // auth Service(),
    final authService = AuthService();
    // try to Login(),
    try {
      await authService.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      if (context.mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text('Log In'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.message,
                  size: 60, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 20),
              Text("Welcome to the Chat App",
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
              const SizedBox(
                height: 20,
              ),
              MyButton(
                  text: "Log In",
                  onTap: () {
                    logIn(context);
                    print("Trying to log in");
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 15)),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(' Sign up here',
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
