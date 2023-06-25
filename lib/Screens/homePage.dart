import 'package:bookdb/Screens/categoryPage.dart';
import 'package:bookdb/Screens/savedPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookdb/auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await Auth().signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
        title: Text(
          "BookDb",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: footer(),
    );
  }

  final List<Widget> _pages = <Widget>[
    ListView.builder(
        itemCount: 1,
        itemBuilder: (context, snapshot) {
          Future<int> bookCount(category) async {
            final _booksQuery = FirebaseFirestore.instance
                .collection('books')
                .where('category', isEqualTo: category);
            final QuerySnapshot snapshot = await _booksQuery.get();

            return snapshot.docs.length;
          }

          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            height: MediaQuery.of(context).size.height,
            color: Colors.grey.shade300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryPage(category: "Bilim Kurgu"),
                              ));
                        },
                        child: FutureBuilder(
                            future: bookCount("Bilim Kurgu"),
                            builder: (context, snapshot) {
                              final int count = snapshot.data ?? 0;
                              return getExpanded(
                                  'book', 'Bilim & Kurgu', '$count Kitap');
                            })),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryPage(category: "Macera"),
                              ));
                        },
                        child: FutureBuilder(
                            future: bookCount("Macera"),
                            builder: (context, snapshot) {
                              final int count = snapshot.data ?? 0;
                              return getExpanded('books-stack-of-three',
                                  'Macera', '$count Kitap');
                            })),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryPage(category: "Edebiyat"),
                              ));
                        },
                        child: FutureBuilder(
                            future: bookCount("Edebiyat"),
                            builder: (context, snapshot) {
                              final int count = snapshot.data ?? 0;
                              return getExpanded(
                                  'books', 'Edebiyat', '$count Kitap');
                            })),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryPage(category: "Çocuk"),
                              ));
                        },
                        child: FutureBuilder(
                            future: bookCount("Çocuk"),
                            builder: (context, snapshot) {
                              final int count = snapshot.data ?? 0;
                              return getExpanded(
                                  'book-stack', 'Çocuk', '$count Kitap');
                            })),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryPage(category: "Gençlik"),
                              ));
                        },
                        child: FutureBuilder(
                            future: bookCount("Gençlik"),
                            builder: (context, snapshot) {
                              final int count = snapshot.data ?? 0;
                              return getExpanded(
                                  'book1', 'Gençlik', '$count Kitap');
                            })),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryPage(category: "Roman"),
                              ));
                        },
                        child: FutureBuilder(
                            future: bookCount("Roman"),
                            builder: (context, snapshot) {
                              final int count = snapshot.data ?? 0;
                              return getExpanded(
                                  'book2', 'Roman', '$count Kitap');
                            })),
                  ],
                ),
              ],
            ),
          );
        }),
   
         SavedPage(),
      
  ];

  BottomNavigationBar footer() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark), label: "Kaydedilenlerim"),
      ],
      currentIndex: _selectedIndex,
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          "$subText",
          style: TextStyle(fontSize: 13.0),
        ),
      ],
    ),
    margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),
      boxShadow: [
        BoxShadow(),
      ],
    ),
  );
}
