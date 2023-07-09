import 'package:bookdb/Screens/forgotPasswordPage.dart';
import 'package:bookdb/Screens/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:bookdb/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool rememberMe = false;
  bool _obscureText = true;
  bool _isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
              "Hatalı bir giriş yaptınız, lütfen daha önce kullanılmamış bir mail veya şifrenizi minimum 6 karakterden uzun giriniz.",
            ),
          );
        },
      );
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              },
              icon: Icon(Icons.book_online)),
        ],
        title: const Text('BookDB'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          //Icon:
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: const Icon(
                Icons.lock,
                size: 99,
                color: Colors.grey,
              ),
            ),

            //Kullanıcı Adı - E mail
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                  labelText: 'E-Mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            // Parola Container
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controllerPassword,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Parola',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),
                    const Text('Beni Hatırla'),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Şifremi Unuttum',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                _isLogin
                    ? signInWithEmailAndPassword()
                    : createUserWithEmailAndPassword();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
              ),
              child: Text(
                _isLogin ? 'Giriş Yap' : 'Kayıt Ol',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              '- veya -',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: MediaQuery.of(context).size.width * 0.55,
              height: 50,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(
                  _isLogin ? 'Kayıt Ol' : 'Giriş Yap',
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SignInButton(
              Buttons.Google,
              text: "Google İle Giriş Yap",
              elevation: 15,
              onPressed: () {
                try {
                  Auth().signInWithGoogle();
                  // ignore: empty_catches
                } catch (e) {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
