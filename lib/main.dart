import 'package:counter/profile_screen.dart';
import 'package:counter/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final storage = new FlutterSecureStorage();
    Future<bool> checkLoginStatus() async {
      String? value = await storage.read(key: "uid");
      if (value == null) {
        return false;
      }
      return true;
    }

    return MaterialApp(
      home: FutureBuilder(
          future: checkLoginStatus(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == false) {
              return HomePage();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ProfileScreen();
          }),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final storage = new FlutterSecureStorage();
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found ") {
        print("No User found for that email");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Help Me Recall",
              style: TextStyle(
                  fontFamily: "Montserrat Regular",
                  color: Colors.black,
                  fontSize: 44,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              "Login",
              style: TextStyle(
                  fontFamily: "Montserrat Regular",
                  color: Colors.blueAccent,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 44.0,
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "User Email",
                prefixIcon: Icon(Icons.mail, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "User Password",
                prefixIcon: Icon(Icons.lock, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              "Forgot password ?",
              style: TextStyle(
                  fontFamily: "Montserrat Regular", color: Colors.blue),
            ),
            const SizedBox(
              height: 66.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () async {
                  User? user = await loginUsingEmailPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context);
                  print(user?.uid);
                  await storage.write(key: "uid", value: user?.uid);
                  if (user != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ProfileScreen()));
                  }
                },
                child: const Text("Login",
                    style: TextStyle(
                      fontFamily: "Montserrat Regular",
                      color: Colors.white,
                      fontSize: 18.0,
                    )),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            signUpOption()
          ],
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(
                fontFamily: "Montserrat Regular", color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " SIGN UP",
            style: TextStyle(
                fontFamily: "Montserrat Regular",
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
