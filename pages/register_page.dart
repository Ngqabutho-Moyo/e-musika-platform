import 'package:ecommerce_3/components/my_button.dart';
// import 'package:ecommerce_3/components/my_error_handler.dart';
import 'package:ecommerce_3/components/my_text_field.dart';
// import 'package:ecommerce_3/components/square_tile.dart';
import 'package:ecommerce_3/models/auth.dart';
// import 'package:ecommerce_3/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final User? user = Auth().currentUser;

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> signUpUser() async {
    // sign in
    try {
      // create user if passwords match
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        // show error: password mismatch
        showErrorMessage('Passwords do not match');
        passwordController.clear();
        confirmPasswordController.clear();
        return;
      }
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message.toString());
      return;
    }
  }

  void showErrorMessage(String error) {
    showDialog(
        context: context,
        builder: (
          context,
        ) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(error),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                // logo
                const Icon(
                  Icons.lock,
                  size: 50,
                ),
                const SizedBox(
                  height: 25,
                ),

                // welcome back
                Text(
                  'Create Account',
                  style: TextStyle(color: Colors.grey[700], fontSize: 18),
                ),
                const SizedBox(
                  height: 25,
                ),
                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 25,
                ),
                // password
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),

                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),

                const SizedBox(
                  height: 25,
                ),

                // sign in button
                MyButton(
                  onTap: signUpUser,
                  text: 'Sign Up',
                ),

                const SizedBox(
                  height: 25,
                ),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      //   child: Text(
                      //     'or continue with',
                      //     style: TextStyle(color: Colors.grey[700]),
                      //   ),
                      // ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                // google sign in
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SquareTile(
                //         onTap: () {
                //           ();
                //         },
                //         imagePath: 'assets/logos/google-logo-3.png'),
                //   ],
                // ),
                const SizedBox(
                  height: 50,
                ),

                // not a member? register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
