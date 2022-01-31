import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _signInAnonymously() async {
    try {
      final user = (await FirebaseAuth.instance.signInAnonymously()).user;
      print('User id is : ${user!.uid}');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            child: Image.asset(
              "assets/google.png",
              width: 240,
            ),
            onTap: () {}),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: _signInAnonymously,
          child: const Text('Signin Annonymously'),
        ),
      ],
    );
  }
}
