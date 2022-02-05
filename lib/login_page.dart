import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_login/controllers/login_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //late final GoogleSignIn _googleSignIn;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login App"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      

      body: loginUI(),
    );
  }

  // creating a function loginUI

  loginUI() {
    // loggedINUI
    // loginControllers

    return Consumer<LoginController>(builder: (context, model, child) {
      // if we are already logged in
      if (model.userDetails != null) {
        return Center(
          child: loggedInUI(model),
        );
      } else {
        return loginControllers(context);
      }
    });
  }

  loggedInUI(LoginController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      // our ui will have 3 children, name, email, photo , logout button

      children: [
        CircleAvatar(
          backgroundImage:
              Image.network(model.userDetails!.photoURL ?? "").image,
          radius: 50,
        ),

        Text(model.userDetails!.displayName ?? ""),
        Text(model.userDetails!.email ?? ""),

        // logout
        ActionChip(
            avatar: const Icon(Icons.logout),
            label: const Text("Logout"),
            onPressed: () {
              Provider.of<LoginController>(context, listen: false).logout();
            })
      ],
    );
  }

  loginControllers(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              child: Image.asset(
                "assets/google.png",
                width: 240,
              ),
              onTap: () async {
                await Provider.of<LoginController>(context, listen: false)
                    .googleLogin();
              }),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _signInAnonymously,
            child: const Text('Signin Annonymously'),
          ),
        ],
      ),
    );
  }
}
