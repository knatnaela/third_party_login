import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:third_party_login/common/utils.dart';

///ThirdPartyLoginWithPhoneNumber
class ThirdPartyLoginWithPhoneNumber {
  late String _verificationId;
  late int? _resendToken;
  late String? _phoneNumber;
  bool _autoResend = false;

  ///verify phone number
  Future<String?> _verifyPhoneNumber(
      {required String phoneNumber, int? timeOut, int? resendToken}) async {
    try {
      await Utils().auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: _verificationCompleted,
          verificationFailed: _verificationFailed,
          codeSent: _codeSent,
          timeout: Duration(seconds: timeOut ?? 60),
          forceResendingToken: resendToken,
          codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
      return "Code Sent Success";
    } catch (e) {
      rethrow;
    }
  }

  ///on verification complete this method is called by firebase auth
  _verificationCompleted(PhoneAuthCredential phoneAuthCredential) {}

  ///on verification failed this method is called by firebase auth
  _verificationFailed(FirebaseAuthException authException) {
    throw authException;
  }

  ///on code send this method is called by firebase auth
  _codeSent(String verificationId, int? forceResendingToken) {
    _verificationId = verificationId;
    _resendToken = forceResendingToken;
  }

  ///on code auto retrieval timed out  this method is called by firebase auth
  _codeAutoRetrievalTimeout(String verificationId) {
    _verificationId = verificationId;
    if (_autoResend) {
      _verifyPhoneNumber(phoneNumber: _phoneNumber!, resendToken: _resendToken);
    }
  }

  ///This method will start phone number verification
  ///pass [phoneNumber] which is required to verify this is required
  ///pass [timeOut] this is time out for code auto retrieval default is 30sec
  ///pass [resendToken] when you want to resend the code
  ///if code send successfully Code sent success message will be returned
  Future<String?> init(
      {required String phoneNumber,
      int? timeOut,
      bool autoSMSResend = false}) async {
    _autoResend = autoSMSResend;
    try {
      return await _verifyPhoneNumber(
          phoneNumber: phoneNumber, timeOut: timeOut);
    } catch (e) {
      rethrow;
    }
  }

  ///call this method and pass [smsCode] to verify the code you just got
  ///if the verification success if will sign-in with the credential and return UserCredential
  Future<UserCredential?> verifyCode({required String smsCode}) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsCode);
      final credential =
          await Utils().signInWithCredential(phoneAuthCredential);
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  ///resendSms
  ///if you want to trigger resend sms manually call this method
  ///if code send successfully Code sent success message will be returned
  Future<String?> resendSms() async {
    try {
      await _verifyPhoneNumber(
          phoneNumber: _phoneNumber!, resendToken: _resendToken);
      return "Code Sent Success";
    } catch (e) {
      rethrow;
    }
  }
}
