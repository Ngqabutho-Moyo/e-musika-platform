import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInExample extends StatefulWidget {
  const GoogleSignInExample({super.key});

  @override
  State<GoogleSignInExample> createState() => _GoogleSignInExampleState();
}

class _GoogleSignInExampleState extends State<GoogleSignInExample> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
