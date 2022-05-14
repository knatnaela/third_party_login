import 'package:firebase_auth/firebase_auth.dart';
import 'package:third_party_login/common/utils.dart';

///ThirdPartyLoginWithPhoneNumber
abstract class ThirdPartyLoginWithPhoneNumber {
  Future<void> verifyPhoneNumber(
      {required String phoneNumber, int? timeOut, int? resendToken}) async {
    try {
      await Utils().auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          timeout: Duration(seconds: timeOut ?? 60),
          forceResendingToken: resendToken,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      rethrow;
    }
  }

  verificationCompleted(PhoneAuthCredential phoneAuthCredential);

  verificationFailed(FirebaseAuthException authException);

  codeSent(String verificationId, int? forceResendingToken);

  codeAutoRetrievalTimeout(String verificationId);

  Future<void> init(
      {required String phoneNumber, int? timeOut, int? resendToken}) async {
    await verifyPhoneNumber(
        phoneNumber: phoneNumber, timeOut: timeOut, resendToken: resendToken);
  }
}
