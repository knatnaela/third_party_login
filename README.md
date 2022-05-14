## Third Party Login

Third Party Login is simple way to sign-in with different types of third party login systems.

## Features

- Login With Google SignIn
- Login With Facebook SignIn

## Getting started

First you need to follow Google sign-in package instructions see [Google Sign-In Git repo](https://github.com/flutter/plugins/tree/master/packages/google_sign_in/google_sign_in)

## Usage

**1. Add the package to pubspec.yaml dependency:**

```yaml
dependencies:
  third_party_login: ^1.0.3
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

### AuthTypes

- google
- facebook
