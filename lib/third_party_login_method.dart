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

    //switch AuthType for dedicated sign-in method
    switch (authType) {
      //google sign-in method
      case AuthType.google:
        //Initialize
        ThirdPartyLoginWithGoogle thirdPartyLoginWithGoogle =
            ThirdPartyLoginWithGoogle();
        userCredential = await thirdPartyLoginWithGoogle.signInWithGoogle();
        break;
      //facebook sign-in method
      case AuthType.facebook:
        //Initialize
        ThirdPartyLoginWithFacebook thirdPartyLoginWithFacebook =
            ThirdPartyLoginWithFacebook();
        userCredential = await thirdPartyLoginWithFacebook.signInWithFacebook();
        break;
      //apple sign-in method
      case AuthType.apple:
        //Initialize
        ThirdPartyLoginWithApple thirdPartyLoginWithApple =
            ThirdPartyLoginWithApple();
        userCredential = await thirdPartyLoginWithApple.signInWithApple();
        break;

      default:
    }
    return userCredential;
  }
}
