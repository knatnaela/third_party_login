part of third_party_login;

///ThirdPartyLoginMethods
class ThirdPartyLoginMethods {
  ///SocialMediaLogin
  ///This method is used to sign-in with different third party login system
  ///Pass AuthType enum
  ///```dart
  ///socialMediaLogin(AuthType.google)
  ///```
  ///
  Future<UserCredential?> socialMediaLogin({required AuthType authType}) async {
    //Firebase UserCredential
    UserCredential? userCredential;

    //Initialize
    ThirdPartyLoginWithGoogle thirdPartyLoginWithGoogle =
        ThirdPartyLoginWithGoogle();
    //switch AuthType for dedicated sign-in method
    switch (authType) {
      //google sign-in method
      case AuthType.google:
        userCredential = await thirdPartyLoginWithGoogle.signInWithGoogle();
        break;
      default:
    }
    return userCredential;
  }
}
