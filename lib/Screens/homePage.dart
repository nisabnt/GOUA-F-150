import 'package:bookdb/Screens/achievementPage.dart';
import 'package:bookdb/Screens/categoryPage.dart';
import 'package:bookdb/Screens/login_screen.dart';
import 'package:bookdb/Screens/savedPage.dart';
import 'package:bookdb/Screens/settingsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookdb/auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final User? user = Auth().currentUser;
  int _selectedIndex = 0;

  // Future<int> bookCount(category) async {
  //   final _booksQuery = FirebaseFirestore.instance
  //       .collection('books')
  //       .where('category', isEqualTo: category);
  //   final QuerySnapshot snapshot = await _booksQuery.get();

  //   return snapshot.docs.length;
  // }
  //await Auth().signOut();
  // Auth().currentUser != null
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 33, 36, 1),
        
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
              icon: Icon(
                Icons.settings,
                color: _selectedIndex == 3 ? Colors.redAccent : Colors.white,
              )),
        ],
        
        title: Text(
          "BookDB",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(30, 33, 36, 1),
      body: _pages[_selectedIndex],
      bottomNavigationBar: footer(),
    );
  }

  final List<Widget> _pages = <Widget>[
    GridView.builder(
      
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 2),
      itemCount: 10,
      itemBuilder: (context, index) {
        final pageWithNames = [
          ["Bilim Kurgu", "science-fiction", "Bilim & Kurgu"],
          ["Macera", "adventure", "Macera"],
          ["Edebiyat", "edebiyat", "Edebiyat"],
          ["Çocuk", "children", "Çocuk"],
          ["Gençlik", "youth", "Gençlik"],
          ["Kişisel Gelişim", "kisisel_gelisim", "Kişisel Gelişim"],
          ["Felsefe", "Philosophy", "Felsefe"],
          ["Psikoloji", "psychology", "Psikoloji"],
          ["Bilim", "science", "Bilim"],
          ["Tarih", "Tarih", "Tarih"],
        ];
        Future<int> bookCount(category) async {
          final _booksQuery = FirebaseFirestore.instance
              .collection('books')
              .where('category', isEqualTo: category);
          final QuerySnapshot snapshot = await _booksQuery.get();

          return snapshot.docs.length;
        }

        return FutureBuilder(
          future: bookCount(pageWithNames[index][0]),
          builder: (context, snapshot) {
            final int count = snapshot.data ?? 0;
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryPage(category: pageWithNames[index][0]),
                      ));
                },
                child: getExpanded(pageWithNames[index][1],
                    pageWithNames[index][2], "$count Kitap"));
          },
        );
      },
    ),
    SavedPage(),
    achievementPage(),
    SettingsPage(),
  ];

  BottomNavigationBar footer() {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(30, 33, 36, 1),
      unselectedItemColor: Colors.white,
      selectedItemColor: _selectedIndex == 3 ? Colors.white : Colors.redAccent,
      selectedFontSize: _selectedIndex == 3 ? 12 : 14,
      unselectedLabelStyle: TextStyle(color: Colors.white),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark), label: "Kaydedilenlerim"),
        BottomNavigationBarItem(
            icon: Icon(MdiIcons.trophy), label: "Başarılarım"),
      ],
      currentIndex: _selectedIndex == 3 ? 0 : _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
    );
  }
}

Container getExpanded(String image, String mainText, String subText) {
  return Container(
    height: 200,
    width: 150,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'images/$image.png',
          height: 80.0,
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          "$mainText",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.5, color: Colors.white),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          "$subText",
          style: TextStyle(fontSize: 16.5, color: Colors.redAccent),
        ),
      ],
    ),
    margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
    decoration: BoxDecoration(
      color: Color.fromRGBO(30, 33, 36, 0.7),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      boxShadow: [
        BoxShadow(),
      ],
    ),
  );
}
