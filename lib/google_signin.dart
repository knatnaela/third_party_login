import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

///ThirdPartyLoginWithGoogle
class ThirdPartyLoginWithGoogle {
  //Initialize GoogleSignIn
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //Initialize FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///SignInWith Google
  Future<UserCredential?> signInWithGoogle() async {
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
      UserCredential? userCredential = await _signInWithCredential(credential);

      //after signing with a given credential return FirebaseUserCredential
      return userCredential;
    } catch (e) {
      //throw exception
      rethrow;
    }
  }

  ///SignIn with Credential to Firebase
  Future<UserCredential?> _signInWithCredential(
      AuthCredential credential) async {
    try {
      //sign-in with provided credential to firebase
      return await _auth.signInWithCredential(credential);

      //firebase auth exception
    } on FirebaseAuthException catch (e) {
      //check if user tried to provide already signed in user with different third party login system
      //for e.g if user signed in with google and that credential is saved in firebase
      //and user tries to sign in with facebook with the same email
      //firebase throws account exists with different credential
      //to solve this we need to link those accounts in to one
      if (e.code == 'account-exists-with-different-credential') {
        // get email from exception
        String email = e.email!;

        //get pending credential from exception
        AuthCredential pendingCredential = e.credential!;

        //get sign-in methods from exception
        List<String> userSignInMethods =
            await _auth.fetchSignInMethodsForEmail(email);

        //check in which sign-in method user signed in first
        if (userSignInMethods.first == "google.com" ||
            userSignInMethods.first == "facebook.com" ||
            userSignInMethods.first == "apple.com") {
          //sign with credential with found credential
          var userCredential = await _auth.signInWithCredential(credential);

          //link pending credential with previous one
          userCredential.user!.linkWithCredential(pendingCredential);
        }
      }
    }
  }
}
