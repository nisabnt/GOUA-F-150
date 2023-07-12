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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'BookBD uygulaması, günümüzde film listelerinde gezinebileceğimiz, izlediğimiz filmleri kaydedebileceğimiz, bunları puanlayabileceğimiz ve birçok özelliğe sahip uygulamaların varlığı fakat bunun kitaplar için olmaması ihtiyacı üzerine tasarlanmıştır. Kitapsever her yaştan insanımızın varlığının farkında olup daha çok gençlerin asıl kullanıcı kesimimiz olarak hedefe alınma sebebi, birçoğumuzun okuduğu, okuyacağı şeyleri(birçok tür içerir) liste haline getirme ve bununla ilgili genel kanıyı merak etme(puanlama sonucunu) durumumuzla ilgilidir. Burada kullanıcılarımız aradığı kitaba erişme, kitabın özetini okuyabilme, kitabı \'okuduklarım,\'okuyacaklarım\' listelerine kaydedebilme, beğenme durumlarına göre puan verme ve verilen genel ortalamayı görerek fikir sahibi olmak gibi pek çok fonksiyonu bir arada kullanabilecektir. Uygulamamızın amacı sektördeki film versiyonun kitap için olan halini karşılamak,o an aklımıza gelen kitabı listeye eklemek,okuyucuların kitap hakkındaki beğeni oranını görebilmek gibi faaliyetleri içererek keyifli bir kullanım sunmaktır. Bu uygulamayla aynı zamanda insanların kitap okumaya teşvik edileceği, özendirileceği düşünülmektedir.',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
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
            'Uygulama içindeki temel özellikleri kullanmak için aşağıdaki adımları izleyebilirsiniz:\n\n1. Ana sayfada arama çubuğunu kullanarak istediğiniz kitabı arayabilirsiniz.\n\n2. Arama sonuçlarından istediğiniz kitaba dokunun ve detay sayfasına gidin.\n\n3. Detay sayfasında kitabın özetini, yazarını, yayınevi bilgilerini görebilirsiniz.\n\n4. Kitabı "Okuduklarım" veya "Okuyacaklarım" listesine eklemek için ilgili butonları kullanabilirsiniz.\n\n5. Beğendiğiniz kitaplara puan vermek için kitap detay sayfasında bulunan puanlama bölümünü kullanabilirsiniz.\n\n6. Ayarlar sayfasından koyu tema ve bildirim ayarlarını düzenleyebilirsiniz.\n\n7. Çıkış yapmak istediğinizde "Çıkış Yap" butonunu kullanabilirsiniz.\n\nBu şekilde BookBD uygulamasını verimli bir şekilde kullanabilirsiniz. Daha fazla yardıma ihtiyaç duyarsanız lütfen bizimle iletişime geçin.',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
