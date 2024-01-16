import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:third_party_login/third_party_login.dart';
import 'package:third_party_login/third_party_login_with_phone_number.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ThirdPartyLoginMethods thirdPartyLoginMethods;
  late UserCredential? userCredential;
  TextEditingController phone = TextEditingController();
  TextEditingController sms = TextEditingController();
  String photoUrl = "";
  String displayName = "";
  String uuid = "";
  late ThirdPartyLoginWithPhoneNumber thirdPartyLoginWithPhoneNumber;

  @override
  void initState() {
    thirdPartyLoginMethods = ThirdPartyLoginMethods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (photoUrl.isNotEmpty)
              CircleAvatar(
                backgroundImage: NetworkImage(photoUrl),
                radius: 32,
                backgroundColor: Colors.black,
              ),
            const SizedBox(
              height: 10,
            ),
            if (photoUrl.isNotEmpty)
              Text(
                displayName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.amber,
              child: TextButton(
                child: const Text(
                  'SignIn With Google',
                ),
                onPressed: () => signIn(AuthType.google),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.redAccent,
              child: TextButton(
                child: const Text(
                  'SignOut from Google',
                ),
                onPressed: () => signOut(AuthType.google),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.blue,
              child: TextButton(
                child: const Text(
                  'SignIn With Facebook',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => signIn(AuthType.facebook),
              ),
            ),
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.red,
              child: TextButton(
                child: const Text(
                  'Verify Phone',
                ),
                onPressed: () => verifyPhone(),
              ),
            ),
            TextField(
              controller: sms,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black,
              child: TextButton(
                child: const Text(
                  'Verify Code',
                ),
                onPressed: () => verifyCode(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential?> signIn(AuthType authType) async {
    userCredential =
        await thirdPartyLoginMethods.socialMediaLogin(authType: authType);
    setState(() {
      userCredential = userCredential;
      photoUrl = userCredential?.user?.photoURL ?? "";
      displayName = userCredential?.user?.displayName ?? "";
    });
    return null;
    // print(googleSignIn.onTap());
  }

  Future<void> signOutFromGoogle() async {}

  verifyPhone() async {
    thirdPartyLoginWithPhoneNumber = ThirdPartyLoginWithPhoneNumber();
    try {
      String? message =
          await thirdPartyLoginWithPhoneNumber.init(phoneNumber: phone.text);
      debugPrint(message);
    } catch (e) {
      inspect(e);
    }
  }

  verifyCode() async {
    try {
      userCredential =
          await thirdPartyLoginWithPhoneNumber.verifyCode(smsCode: sms.text);

      inspect(userCredential);
    } catch (e) {
      inspect(e);
    }
  }

  resend(String phoneNumber) async {
    try {
      final String? message = await thirdPartyLoginWithPhoneNumber.resendSms(
          phoneNumber: phoneNumber);
      debugPrint(message);
    } catch (e) {
      inspect(e);
    }
  }

  signOut(AuthType authType) async {
    await thirdPartyLoginMethods.signOut(authType: authType);
  }
}
