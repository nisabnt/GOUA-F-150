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
            content: Text("Şifre sıfırlama maili gönderildi lütfen e-mailinizi kontrol edin!", style: TextStyle(color: Colors.white),),
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(30, 33, 36, 1),
            content: Text("Kullanıcı bulunamadı.", style: TextStyle(color: Colors.white),),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 33, 36, 1),
      appBar: AppBar(backgroundColor: Color.fromRGBO(30, 33, 36, 1),),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Lütfen Şifre Sıfırlama Maili İçin e-postanızı Girin",
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
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _controllerEmail,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'e-posta',
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
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
