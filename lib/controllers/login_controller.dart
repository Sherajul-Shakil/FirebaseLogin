import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_login/model/user_details.dart';

class LoginController with ChangeNotifier {
  // object
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetails? userDetails;

  // fucntion for google login
  Future<void> googleLogin() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      // inserting values to our user details model
      print(googleUser.toString());

      userDetails = UserDetails(
        displayName: googleUser!.displayName,
        email: googleUser.email,
        photoURL: googleUser.photoUrl,
      );
      // final googleAuthentication = await googleUser!.authentication;
      // final authCredential = GoogleAuthProvider.credential(
      //   idToken: googleAuthentication.idToken,
      //   accessToken: googleAuthentication.accessToken,
      // );
      // await _googleSignIn.signInWithCredential(authCredential);
      print(userDetails.toString());
    } catch (e) {
      print(e);
    }

    // call
    notifyListeners();
  }

  // logout

  Future<void> logout() async {
    googleSignInAccount = await _googleSignIn.signOut();
    userDetails = null;
    notifyListeners();
  }
}
