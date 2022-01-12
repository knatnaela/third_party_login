import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ThirdPartyLoginWithGoogle {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      AuthCredential? credential;
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return null;
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential? userCredential = await _signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> _signInWithCredential(
      AuthCredential credential) async {
    try {
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        String email = e.email!;
        AuthCredential pendingCredential = e.credential!;
        List<String> userSignInMethods =
            await _auth.fetchSignInMethodsForEmail(email);

        if (userSignInMethods.first == "google.com" ||
            userSignInMethods.first == "facebook.com" ||
            userSignInMethods.first == "apple.com") {
          var userCredential = await _auth.signInWithCredential(credential);
          userCredential.user!.linkWithCredential(pendingCredential);
        }
      }
    }
  }
}
