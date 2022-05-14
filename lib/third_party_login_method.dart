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
  Future<UserCredential?> socialMediaLogin(
      {required AuthType authType, String? phoneNumber}) async {
    //Firebase UserCredential
    UserCredential? userCredential;

    //switch AuthType for dedicated sign-in method
    switch (authType) {
      //google sign-in method
      case AuthType.google:
        //Initialize
        ThirdPartyLoginWithGoogle thirdPartyLoginWithGoogle =
            ThirdPartyLoginWithGoogle();
        userCredential = await thirdPartyLoginWithGoogle.signInWithGoogle();
        break;
      //google facebook sign-in method
      case AuthType.facebook:
        //Initialize
        ThirdPartyLoginWithFacebook thirdPartyLoginWithFacebook =
            ThirdPartyLoginWithFacebook();
        userCredential = await thirdPartyLoginWithFacebook.signInWithFacebook();
        break;
      default:
    }
    return userCredential;
  }
}
