import 'dart:developer';

import 'package:firebase_auth_platform_interface/src/providers/phone_auth.dart';
import 'package:firebase_auth_platform_interface/src/firebase_auth_exception.dart';
import 'package:third_party_login/common/utils.dart';
import 'package:third_party_login/thord_party_login_with_phone_number.dart';

class PhoneAuth extends ThirdPartyLoginWithPhoneNumber {
  String? verificationId;
  int? resendToken;
  @override
  codeAutoRetrievalTimeout(String verificationId) {
    // TODO: implement codeAutoRetrievalTimeout
  }

  @override
  codeSent(String verificationId, int? forceResendingToken) {
    print("code sent");
    this.verificationId = verificationId;
    resendToken = forceResendingToken;
  }

  @override
  verificationCompleted(PhoneAuthCredential phoneAuthCredential) {
    print("verification completed");
    Utils().signInWithCredential(phoneAuthCredential);
  }

  @override
  verificationFailed(FirebaseAuthException authException) {
    print("verification failed");
    throw authException;
  }

  verifyCode(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!, smsCode: smsCode);
      final Credential = await Utils().signInWithCredential(credential);
    } catch (e) {
      inspect(e);
    }
  }
}
