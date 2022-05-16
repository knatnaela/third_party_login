import 'package:firebase_auth/firebase_auth.dart';
import 'package:third_party_login/common/utils.dart';

///ThirdPartyLoginWithPhoneNumber
abstract class ThirdPartyLoginWithPhoneNumber {
  ///verify phone number
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

  ///on verification complete this method is called by firebase auth
  verificationCompleted(PhoneAuthCredential phoneAuthCredential);

  ///on verification failed this method is called by firebase auth
  verificationFailed(FirebaseAuthException authException);

  ///on code send this method is called by firebase auth
  codeSent(String verificationId, int? forceResendingToken);

  ///on code auto retrieval timed out  this method is called by firebase auth
  codeAutoRetrievalTimeout(String verificationId);

  ///This method will start phone number verification
  ///pass [phoneNumber] which is required to verify this is required
  ///pass [timeOut] this is time out for code auto retrieval default is 30sec
  ///pass [resendToken] when you want to resend the code
  Future<void> init(
      {required String phoneNumber, int? timeOut, int? resendToken}) async {
    await verifyPhoneNumber(
        phoneNumber: phoneNumber, timeOut: timeOut, resendToken: resendToken);
  }
}
