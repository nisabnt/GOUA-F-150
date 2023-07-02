import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _darkModeEnabled = false; // Koyu tema durumunu tutan değişken
  bool _notificationEnabled = false; // Bildirim durumunu tutan değişken

  void _toggleDarkMode(bool value) {
    setState(() {
      _darkModeEnabled = value;
    });
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationEnabled = value;
    });
    if (value) {
      // Bildirimler açıldığında yapılacak işlemler
    } else {
      // Bildirimler kapatıldığında yapılacak işlemler
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ayarlar',
      theme: _darkModeEnabled ? ThemeData.dark() : ThemeData.light(), // Tema ayarlarını koyu veya açık temaya göre belirle
      home: SettingsPage(
        darkModeEnabled: _darkModeEnabled,
        notificationEnabled: _notificationEnabled,
        toggleDarkMode: _toggleDarkMode,
        toggleNotifications: _toggleNotifications,
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  final bool darkModeEnabled;
  final bool notificationEnabled;
  final Function(bool) toggleDarkMode;
  final Function(bool) toggleNotifications;

  SettingsPage({
    required this.darkModeEnabled,
    required this.notificationEnabled,
    required this.toggleDarkMode,
    required this.toggleNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ayarlar',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor, // Başlık çubuğu rengini temaya göre ayarla
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bildirim Ayarları',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            SwitchListTile(
              title: Text('Bildirimleri Aç'),
              value: notificationEnabled,
              onChanged: toggleNotifications, // Bildirim ayarlarını değiştirmek için gerekli fonksiyonu çağır
            ),
            Divider(),
            Text(
              'Temayı Ayarla',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            SwitchListTile(
              title: Text('Koyu Tema'),
              value: darkModeEnabled,
              onChanged: toggleDarkMode, // Koyu tema ayarlarını değiştirmek için gerekli fonksiyonu çağır
            ),
            Divider(),
            SizedBox(height: 16),
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
                    Icon(Icons.info, color: Colors.blue),
                    SizedBox(width: 12),
                    Text(
                      'Hakkında',
                      style: TextStyle(
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
                    Icon(Icons.help, color: Colors.blue),
                    SizedBox(width: 12),
                    Text(
                      'Yardım',
                      style: TextStyle(
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
                    title: Text('Çıkış Yap'),
                    content: Text('Çıkış yapmak istediğinize emin misiniz?'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('İptal'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Çıkış yapma işlemleri
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
                    Icon(Icons.exit_to_app, color: Colors.red),
                    SizedBox(width: 12),
                    Text(
                      'Çıkış Yap',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
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
      appBar: AppBar(
        title: Text('Hakkında'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'BookBD uygulaması, günümüzde film listelerinde gezinebileceğimiz, izlediğimiz filmleri kaydedebileceğimiz, bunları puanlayabileceğimiz ve birçok özelliğe sahip uygulamaların varlığı fakat bunun kitaplar için olmaması ihtiyacı üzerine tasarlanmıştır. Kitapsever her yaştan insanımızın varlığının farkında olup daha çok gençlerin asıl kullanıcı kesimimiz olarak hedefe alınma sebebi, birçoğumuzun okuduğu, okuyacağı şeyleri(birçok tür içerir) liste haline getirme ve bununla ilgili genel kanıyı merak etme(puanlama sonucunu) durumumuzla ilgilidir. Burada kullanıcılarımız aradığı kitaba erişme, kitabın özetini okuyabilme, kitabı \'okuduklarım,\'okuyacaklarım\' listelerine kaydedebilme, beğenme durumlarına göre puan verme ve verilen genel ortalamayı görerek fikir sahibi olmak gibi pek çok fonksiyonu bir arada kullanabilecektir. Uygulamamızın amacı sektördeki film versiyonun kitap için olan halini karşılamak,o an aklımıza gelen kitabı listeye eklemek,okuyucuların kitap hakkındaki beğeni oranını görebilmek gibi faaliyetleri içererek keyifli bir kullanım sunmaktır. Bu uygulamayla aynı zamanda insanların kitap okumaya teşvik edileceği, özendirileceği düşünülmektedir.',
            style: TextStyle(fontSize: 16),
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
      appBar: AppBar(
        title: Text('Yardım'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Uygulama içindeki temel özellikleri kullanmak için aşağıdaki adımları izleyebilirsiniz:\n\n1. Ana sayfada arama çubuğunu kullanarak istediğiniz kitabı arayabilirsiniz.\n\n2. Arama sonuçlarından istediğiniz kitaba dokunun ve detay sayfasına gidin.\n\n3. Detay sayfasında kitabın özetini, yazarını, yayınevi bilgilerini görebilirsiniz.\n\n4. Kitabı "Okuduklarım" veya "Okuyacaklarım" listesine eklemek için ilgili butonları kullanabilirsiniz.\n\n5. Beğendiğiniz kitaplara puan vermek için kitap detay sayfasında bulunan puanlama bölümünü kullanabilirsiniz.\n\n6. Ayarlar sayfasından koyu tema ve bildirim ayarlarını düzenleyebilirsiniz.\n\n7. Çıkış yapmak istediğinizde "Çıkış Yap" butonunu kullanabilirsiniz.\n\nBu şekilde BookBD uygulamasını verimli bir şekilde kullanabilirsiniz. Daha fazla yardıma ihtiyaç duyarsanız lütfen bizimle iletişime geçin.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
