import 'dart:ffi';

import 'package:bookdb/Screens/ratingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../auth.dart';

class detailPage extends StatefulWidget {
  final book;
  const detailPage({super.key, required this.book});

  @override
  State<detailPage> createState() => _detailPageState(book);
}

class _detailPageState extends State<detailPage> {
  var book;

  _detailPageState(this.book);
  bool _isEnabled = true;
  bool _isEnabledRating = true;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        margin: EdgeInsets.only(top: 30),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.chevron_left_rounded,
                size: 30,
              )),
          Text(
            "Kitap Detayı",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          InkWell(onTap: () {
             Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RatingPage(book: book),
                    ));
          }, child: Icon(Icons.graphic_eq)),
        ]),
      );
    }

    Widget bookImage() {
      return Container(
        height: 267,
        width: 175,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(book["image"]))),
      );
    }

    Widget infoDescription() {
      Map<String, dynamic> ratingData = book["rating"];
      List<dynamic> saveData = book["save"];
      int count = 0, star = 0;
      ratingData.forEach((key, value) {
        star += int.parse(value);
        count++;
      });

      final rating = star / count;
      return Container(
        height: 60,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.blueGrey[50], borderRadius: BorderRadius.circular(9)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            children: [
              Text(
                "Yıldız",
                style: TextStyle(
                    color: Colors.grey[600], fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                    color: Colors.grey[900], fontWeight: FontWeight.bold),
              ),
            ],
          ),
          VerticalDivider(
            color: Colors.grey,
            thickness: 1,
          ),
          Column(
            children: [
              Text(
                "Sayfa",
                style: TextStyle(
                    color: Colors.grey[600], fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                book["page"],
                style: TextStyle(
                    color: Colors.grey[900], fontWeight: FontWeight.bold),
              ),
            ],
          ),
          VerticalDivider(
            color: Colors.grey,
            thickness: 1,
          ),
          Column(
            children: [
              Text(
                "Kaydedilen",
                style: TextStyle(
                    color: Colors.grey[600], fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                saveData.length.toString(),
                style: TextStyle(
                    color: Colors.grey[900], fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ]),
      );
    }

    Widget saveButton() {
      final uid = Auth().currentUser?.uid;
      List<dynamic> saveData = book["save"];
      bool save = saveData.contains(uid);

      return Positioned(
        top: 400,
        right: 30,
        child: InkWell(
          onTap: _isEnabled
              ? () async {
                  setState(() {
                    _isEnabled = false;
                  });

                  if (save) {
                    saveData.remove(uid);

                    await FirebaseFirestore.instance
                        .collection("books")
                        .doc(book.id)
                        .update({"save": saveData});
                    await FirebaseFirestore.instance
                        .collection("books")
                        .doc(book.id)
                        .get()
                        .then((value) {
                      book = value;
                    });
                    setState(() {
                      _isEnabled = true;
                    });
                  } else {
                    saveData.add(uid);

                    await FirebaseFirestore.instance
                        .collection("books")
                        .doc(book.id)
                        .update({"save": saveData});
                    await FirebaseFirestore.instance
                        .collection("books")
                        .doc(book.id)
                        .get()
                        .then((value) {
                      book = value;
                    });
                    setState(() {
                      _isEnabled = true;
                    });
                  }
                }
              : null,
          child: Container(
            height: 50,
            width: 50,

            decoration:
                BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            child: Icon(
              save ? Icons.bookmark_outlined : Icons.bookmark_outline_sharp,
              color: Colors.white,
            ), //bookmark_outline_sharp
          ),
        ),
      );
    }

    Widget rateBook() {
      final uid = Auth().currentUser?.uid;
      Map<String, dynamic> ratingData = book["rating"];

      return Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey[50], borderRadius: BorderRadius.circular(9)),
        child: RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.blue,
          ),
          onRatingUpdate: _isEnabledRating
              ? (rating) async {
                  _isEnabledRating = false;

                  double ratingDouble = double.parse(rating.toString());
                  int ratingInt = ratingDouble.round();
                  ratingData[uid!] = ratingInt.toString();

                  await FirebaseFirestore.instance
                      .collection("books")
                      .doc(book.id)
                      .update({"rating": ratingData});
                  await FirebaseFirestore.instance
                      .collection("books")
                      .doc(book.id)
                      .get()
                      .then((value) {
                    book = value;
                  });
                  setState(() {
                    _isEnabledRating = true;
                  });
                }
              : (value) {},
        ),
      );
    }

    Widget description() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book["name"],
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      book["author"],
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
            ),
          ]),
          SizedBox(
            height: 30,
          ),
          Text(
            'Açıklama',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            book["description"],
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          infoDescription(),
        ]),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  header(),
                  SizedBox(
                    height: 50,
                  ),
                  bookImage(),
                  description(),
                  Auth().currentUser != null ? rateBook() : Container(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Auth().currentUser != null ? saveButton() : Container(),
            ],
          )
        ],
      ),
    );
  }
}
