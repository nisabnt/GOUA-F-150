import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookDB'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          //Icon
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: const Icon(
                Icons.lock,
                size: 100,
                color: Colors.grey,
              ),

            ), //Kullanıcı adı - E mail
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı veya E Mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ), //Kullanıcı adı - E mail
            const SizedBox(height: 16),

            //Parola Container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Parola',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),

            // Giriş yapma işlemleri
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'Giriş Yap',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            // Şifremi Unuttum Butonu
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
              },
              child: const Text(
                'Şifremi Unuttum',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),

            //Google ile giriş yap butonu
            const SizedBox(height: 12),
            SignInButton(
              Buttons.Google,
              onPressed: () {
                // Handle Google Sign-In button pressed
              },
            ),
          ],
        ),
      ),
    );
  }
}