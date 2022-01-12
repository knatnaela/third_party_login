part of third_party_login;

class ThirdPartyLoginMethods {
  Future<UserCredential?> socialMediaLogin({required AuthType authType}) async {
    UserCredential? userCredential;
    ThirdPartyLoginWithGoogle thirdPartyLoginWithGoogle =
        ThirdPartyLoginWithGoogle();
    switch (authType) {
      case AuthType.google:
        userCredential = await thirdPartyLoginWithGoogle.signInWithGoogle();
        break;
      default:
    }
    return userCredential;
  }
}
