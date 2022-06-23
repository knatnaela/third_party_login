import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:third_party_login/common/utils.dart';
import 'package:third_party_login/third_party_login.dart';

///ThirdParty Login With Apple class
@protected
class ThirdPartyLoginWithApple {
  Future<UserCredential?> signInWithApple() async {
    //get generated nonce
    final rawNonce = _generateNonce();
    //encrypt nonce
    final nonce = _sha256ofString(rawNonce);
    //initialize apple credential
    final AuthorizationCredentialAppleID appleCredential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        //set scopes
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    //set credential
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    //sign in with credential
    return await Utils().signInWithCredential(oauthCredential);
  }
}

///generate random nonce
String _generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

///SHA256
String _sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
