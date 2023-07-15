import 'package:flutter/material.dart';

import '../auth.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 33, 36, 1),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Color.fromRGBO(165, 237, 239, 1)),
                    SizedBox(width: 12),
                    Text(
                      'Hakkında',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Icon(Icons.help, color: Color.fromRGBO(0, 231, 239, 1)),
                    SizedBox(width: 12),
                    Text(
                      'Yardım',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                showDialog(
                  
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Color.fromRGBO(30, 33, 36, 1),
                    title: Auth().currentUser != null
                        ? Text('Çıkış Yap', style: TextStyle(color: Colors.white),)
                        : Text('Giriş Yap',
                            style: TextStyle(color: Colors.white),
                          ),
                    content: Auth().currentUser != null
                        ? Text('Çıkış yapmak istediğinize emin misiniz?',
                            style: TextStyle(color: Colors.white),
                          )
                        : Text('Giriş yapmak istediğinize emin misiniz?',
                            style: TextStyle(color: Colors.white),
                          ),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(30, 33, 36, 0.7)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('İptal'),
                      ),
                      ElevatedButton(
                         style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(30, 33, 36, 0.7)),
                        onPressed: () async {
                          Auth().currentUser != null
                              ? await Auth().signOut()
                              : Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text('Evet'),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Icon(
                        Auth().currentUser != null
                            ? Icons.exit_to_app
                            : Icons.login,
                        color: Auth().currentUser != null
                            ? Colors.red
                            : Colors.greenAccent),
                    SizedBox(width: 12),
                    Text(
                      Auth().currentUser != null ? 'Çıkış Yap' : 'Giriş Yap',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Auth().currentUser != null
                            ? Colors.red
                            : Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 33, 36, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 33, 36, 1),
        title: Text('Hakkında'),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, snapshot) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'BookDB uygulaması, günümüzde kitapları inceleyip, okuduklarımızı listemize kaydedip bunlara puan verebileceğimiz ve farklı özelliklere de sahip bir uygulama olarak tasarlanmıştır.'
                    'Geliştirilme sebebi, kitapseverlere hitap etmek üzere bu minvalde bir uygulamanın olmayışı ve buna ihtiyaç duyulmasıdır. '
                    'Kullanıcı kesimimiz kitap okumayı seven her insanı kapsamaktadır.'
                    'Uygulamamız bu kapsam göz önünde bulundurularak açık, anlaşılır, kullanımı kolay ve göze hoş gelen bir şekilde oluşturulmuştur. '
                    'Kullanıcılarımız uygulama içerisinde aradığı kitaba erişme, kitabın özetini okuyabilme, kitabı listesine kaydedebilme, beğenme durumuna göre puan verme ve verilen genel ortalamayı görerek fikir sahibi olmak gibi pek çok fonksiyonu bir arada kullanabilecektir.'
                    'Uygulamanın benzer versiyonlarının farklı amaçlar için kullanıldığı göz önüne alınarak, özellikle kitap için yapılmamış olmaları bizleri bu uygulamayı geliştirmeye teşvik etmiştir. '
                    'Amaçlarımızın bir diğeri de insanları kitap okumaya teşvik etmek ve özendirmektir.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          );
        }
      ),
    );
  }
}

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 33, 36, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 33, 36, 1),
        title: Text('Yardım'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Uygulama içindeki temel özellikleri kullanmak için aşağıdaki adımları izleyebilirsiniz:\n\n'
                '1. Ana sayfada arama çubuğunu kullanarak istediğiniz kitabı arayabilirsiniz.\n\n'
                '2. Arama sonuçlarından istediğiniz kitaba dokunun ve detay sayfasına gidin.\n\n'
                '3. Detay sayfasında kitabın içeriği, yazarı, sayfası sayısı gibi bilgilere erişebilirsiniz.\n\n'
                '4. Kitabı listenize kaydetmek için ilgili butonu kullanabilirsiniz.\n\n'
                '5. Beğendiğiniz kitaplara puan vermek için kitap detay sayfasında bulunan puanlama bölümünü kullanabilirsiniz.\n\n'
                '6. Ayarlar sayfasından koyu tema ve bildirim ayarlarını düzenleyebilirsiniz.\n\n'
                '7. Çıkış yapmak istediğinizde "Çıkış Yap" butonunu kullanabilirsiniz.\n\n'
                '8. Kitap oy oranını görebilir, kendi oyladığınız ve kaydettiğiniz kitaplar sonucunda başarınızın durumunu ölçebilirsiniz.\n\n'
                '9. Uygulamayı giriş yapmadan da kullanabilir, kaydetme, puan verme gibi işlemleri gerçekleştirmek için giriş yapmanız gerekmektedir.\n\n'
                'Bu şekilde BookBD uygulamasını verimli bir şekilde kullanabilirsiniz. Daha fazla yardıma ihtiyaç duyarsanız lütfen bizimle iletişime geçin.',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
