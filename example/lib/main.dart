import 'package:example/phone_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:third_party_login/third_party_login.dart';

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
  PhoneAuth phoneAuth = PhoneAuth();

  String photoUrl = "";
  String displayName = "";
  String uuid = "";
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
                onPressed: () => signInWithGoogle(),
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

  Future<UserCredential?> signInWithGoogle() async {
    thirdPartyLoginMethods = ThirdPartyLoginMethods();
    final credential = await thirdPartyLoginMethods.socialMediaLogin(
        authType: AuthType.google);
    setState(() {
      userCredential = credential;
      photoUrl = credential?.user?.photoURL ?? "";
      displayName = credential?.user?.displayName ?? "";
    });
    return null;
    // print(googleSignIn.onTap());
  }

  verifyPhone() async {
    await phoneAuth.init(
        phoneNumber: phone.text, resendToken: phoneAuth.resendToken);
  }

  verifyCode() {
    phoneAuth.verifyCode(sms.text);
  }
}
