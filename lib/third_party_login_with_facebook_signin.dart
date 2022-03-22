import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:third_party_login/common/utils.dart';
import 'package:third_party_login/third_party_login.dart';

///ThirdParty Login With Facebook class
class ThirdPartyLoginWithFacebook {
  //Initialize FacebookSignIn
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  Future<UserCredential?> signInWithFacebook(
      [linkWithCredential = false]) async {
    LoginResult result = await _facebookAuth.login();
    switch (result.status) {
      case LoginStatus.success:
        //create AuthCredential from provided facebook account
        final AuthCredential _authCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        //sign with a given AuthCredential
        var userCredential =
            await Utils().signInWithCredential(_authCredential);
        return userCredential;
      case LoginStatus.cancelled:
        return null;
      case LoginStatus.failed:
        return null;
      default:
        return null;
    }
  }
}
