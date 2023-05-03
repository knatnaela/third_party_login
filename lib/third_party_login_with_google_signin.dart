import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:third_party_login/common/utils.dart';

///ThirdPartyLoginWithGoogle

@protected
class ThirdPartyLoginWithGoogle {
  //Initialize GoogleSignIn
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  ///SignInWith Google
  Future<UserCredential?> signInWithGoogle([bool link = false]) async {
    try {
      //Initialize AuthCredential
      AuthCredential? credential;

      //Start GoogleSignIn Dialog
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      //check if google sign-in account is not null
      if (googleSignInAccount == null) {
        return null;
      }

      //if google sign-in field is not null authenticate provided google account
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      //create AuthCredential from provided google account
      credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      //sign with a given AuthCredential
      UserCredential? userCredential =
          await Utils().signInWithCredential(credential);

      if (link) {
        await Utils().linkProviders(userCredential!, credential);
      }

      //after signing with a given credential return FirebaseUserCredential
      return userCredential;
    } catch (e) {
      //throw exception
      rethrow;
    }
  }

  ///SignOut Google Credential
  Future<void> signOut() async {
    final response = await _googleSignIn.signOut();
    inspect(response);
  }
}
