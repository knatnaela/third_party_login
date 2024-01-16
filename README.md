## Third Party Login

Third Party Login is simple way to sign-in with different types of third party login systems.

## Features

- Login With Google SignIn
- Login With Facebook SignIn
- Login With Apple SignIn
- Login With PhoneNumber

## Getting started

- For Google sign-in setup instructions see [Google Sign-In Git repo](https://github.com/flutter/plugins/tree/master/packages/google_sign_in/google_sign_in)

- For Facebook sign-in setup instructions see [Facebook sign-in Git repo](https://github.com/darwin-morocho/flutter-facebook-auth)

- For Apple sign-in setup instructions see [Apple sign-in doc](https://developer.apple.com/sign-in-with-apple/get-started)

- For Phone Number verification setup instructions see [Firebase Phone Auth](https://firebase.google.com/docs/auth/flutter/phone-auth)

## Usage

**1. Add the package to pubspec.yaml dependency:**

```yaml
dependencies:
  third_party_login: ^1.0.15
```

**2. Import package:**

```dart
import 'package:third_party_login/third_party_login.dart';
```

**3. Initialize ThirdPartyLoginMethods**

```dart
 ThirdPartyLoginMethods thirdPartyLoginMethods = ThirdPartyLoginMethods();
```

**4. call socialMediaLogin and pass AuthType**

```dart
final userCredential = await thirdPartyLoginMethods.socialMediaLogin(
        authType: AuthType.google);
```

## Usage For Phone Number Verification

- follow step number `1` and `2`

**3. Initialize PhoneNumberAuth class and call init to start phone number verification. if it's successful it will return Code sent Success message**

```dart
PhoneNumberAuth _auth = PhoneNumberAuth();
final String? message = await _auth.init(phoneNumber:contactNumber)
```

Next call `verifyCode` and pass the sms code value to verify the sms code you just got. this method will try to verify your code and if it's successful it will sign-in with the credential and return UserCredential.

```dart
...
final UserCredential? userCredential =
          await thirdPartyLoginWithPhoneNumber.verifyCode(smsCode: sms);
```

### AuthTypes

- google
- facebook
- apple
- phoneNumber
