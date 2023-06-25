import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _controllerEmail = TextEditingController();

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _controllerEmail.text.trim());
          showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Şifre sıfırlama maili gönderildi lütfen e-mailinizi kontrol edin!"),
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Kullanıcı bulunamadı."),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Lütfen Şifre Sıfırlama Maili İçin E-Mailinizi Girin",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 30,
              ),
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
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  passwordReset();
                },
                child: Text(
                  "Şifre Sıfırla",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
