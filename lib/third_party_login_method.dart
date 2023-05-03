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
  //Initialize SignIn With Google
  ThirdPartyLoginWithGoogle thirdPartyLoginWithGoogle =
      ThirdPartyLoginWithGoogle();

  Future<UserCredential?> socialMediaLogin({required AuthType authType}) async {
    //Firebase UserCredential
    UserCredential? userCredential;

    //switch AuthType for dedicated sign-in method
    switch (authType) {
      //google sign-in method
      case AuthType.google:
        //Initialize
        thirdPartyLoginWithGoogle = ThirdPartyLoginWithGoogle();
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

  ///This method is used to sign-out from different third party login system
  ///Pass AuthType enum
  ///```dart
  ///socialMediaLogin(AuthType.google)
  ///```
  ///
  Future<void> signOut({required AuthType authType}) async {
    //switch AuthType for dedicated sign-in method
    switch (authType) {
      //google sign-in method
      case AuthType.google:
        //signout from google
        await thirdPartyLoginWithGoogle.signOut();
        break;
      //facebook sign-in method
      case AuthType.facebook:
        //Initialize

        break;
      //apple sign-in method
      case AuthType.apple:
        //Initialize

        break;

      default:
    }
  }
}
