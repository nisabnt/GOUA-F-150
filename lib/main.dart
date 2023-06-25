import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/login_screen.dart';
import 'Screens/homePage.dart';
import 'auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return MyHomePage();
          }
          else {
            return const LoginScreen();
          }
        },
      ),
      //home: MyHomePage(),
    );
  }
}
