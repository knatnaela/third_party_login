import '../third_party_login.dart';

class Utils {
  static Utils? utils;
  //Initialize FirebaseAuth
  final FirebaseAuth auth = FirebaseAuth.instance;
  static Utils? getInstance() {
    utils ??= Utils();
    return utils;
  }

  ///SignIn with Credential to Firebase
  Future<UserCredential?> signInWithCredential(
      AuthCredential credential) async {
    try {
      //sign-in with provided credential to firebase
      return await auth.signInWithCredential(credential);

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
            await auth.fetchSignInMethodsForEmail(email);

        //check in which sign-in method user signed in first
        if (userSignInMethods.first == "google.com" ||
            userSignInMethods.first == "facebook.com" ||
            userSignInMethods.first == "apple.com") {
          //sign with credential with found credential
          var userCredential = await auth.signInWithCredential(credential);

          //link pending credential with previous one
          return userCredential.user!.linkWithCredential(pendingCredential);
        }
      } else {
        rethrow;
      }
    }
    return null;
  }
}
