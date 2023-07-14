import 'dart:convert';

import 'package:bookdb/Screens/detailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class Book {
  final String title;
  final String description;
  final String image;
  final double rating;

  Book({
    required this.title,
    required this.description,
    required this.image,
    required this.rating,
  });
}

List<Map<String, dynamic>> _books = [];

class CategoryPage extends StatefulWidget {
  final category;

  const CategoryPage({super.key, this.category});
  @override
  State<CategoryPage> createState() => _CategoryPageState(category);
}

class _CategoryPageState extends State<CategoryPage> {
  final categoryName;
  var searchText = "";

  _CategoryPageState(this.categoryName);

  void goDetialPage(context, book) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => detailPage(book: book),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final _booksQuery = FirebaseFirestore.instance
        .collection('books')
        .where('category', isEqualTo: categoryName);

    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 33, 36, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 33, 36, 1),
        title: Text(categoryName),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.redAccent,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Ara',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: StreamBuilder(
                  stream: _booksQuery.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;
                      final List<DocumentSnapshot> matchedDocuments = documents
                          .where((document) => document['name']
                              .toString()
                              .toLowerCase()
                              .contains(searchText.toLowerCase()))
                          .toList();
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 sütun
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75, // Kartların en-boy oranı
                        ),
                        itemCount: matchedDocuments.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              matchedDocuments[index];
                          return buildBookCard(documentSnapshot, context);
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Color.fromRGBO(30, 33, 36, 1),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder(
                  stream: _booksQuery.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      bool puan = false;
                      final List<DocumentSnapshot> documentSnapshot =
                          snapshot.data!.docs;

                      documentSnapshot.sort(
                        (a, b) {
                          final Map<String, dynamic> ratingA = a["rating"];
                          final Map<String, dynamic> ratingB = b["rating"];

                          final String firstKeyA = ratingA.keys.first;
                          final String firstKeyB = ratingB.keys.first;

                          final double ratingValueA =
                              double.parse(ratingA[firstKeyA]) ?? 0;
                          final double ratingValueB =
                              double.parse(ratingB[firstKeyB]) ?? 0;

                          return ratingValueB.compareTo(ratingValueA);
                        },
                      );
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: documentSnapshot.length,
                        itemBuilder: (context, index) {
                          if (index > 9) return null;
                          return buildRecommendedBookCard(
                              documentSnapshot[index], context);
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBookCard(book, context) {
    Map<String, dynamic> ratingData = book["rating"];

    int count = 0, star = 0;
    ratingData.forEach((key, value) {
      star += int.parse(value);
      count++;
    });
    final rating = star / count;
    List<Widget> cards = [
      InkWell(
        onTap: () {
          goDetialPage(context, book);
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(book["image"]),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Chip(
                        avatar: Icon(Icons.star, size: 16, color: Colors.white),
                        backgroundColor: Colors.red,
                        label: Text(
                          rating.toStringAsFixed(1),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      InkWell(
        onTap: () {
          goDetialPage(context, book);
        },
        child: Card(
          color: Colors.red,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      //color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    book["name"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          //color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(5)),
                      child: SingleChildScrollView(
                        child: Text(
                          _truncateDescription(book["description"], 120),
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Chip(
                      avatar: Icon(Icons.star, size: 16, color: Colors.white),
                      backgroundColor: Color.fromRGBO(30, 33, 36, 1),
                      label: Text(
                        rating.toStringAsFixed(1),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ];

    return CardSwiper(
      cardsCount: cards.length,
      numberOfCardsDisplayed: 1,
      cardBuilder: (context, index) => cards[index],
    );
  }

  // Widget buildBookCard(Book book) {
  Widget buildRecommendedBookCard(book, context) {
    Map<String, dynamic> ratingData = book["rating"];

    int count = 0, star = 0;
    ratingData.forEach((key, value) {
      star += int.parse(value);
      count++;
    });
    final rating = star / count;
    return InkWell(
      onTap: () {
        goDetialPage(context, book);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(book["image"]),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Chip(
                      avatar: Icon(Icons.star, size: 16, color: Colors.white),
                      backgroundColor: Colors.red,
                      label: Text(
                        rating.toStringAsFixed(1),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _truncateDescription(String description, int maxLength) {
    if (description.length <= maxLength) {
      return description;
    } else {
      return '${description.substring(0, maxLength - 3)}...';
    }
  }
}
