import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../auth.dart';

class achievementPage extends StatefulWidget {
  const achievementPage({super.key});

  @override
  State<achievementPage> createState() => _achievementPageState();
}

class _achievementPageState extends State<achievementPage> {
  var achievements = [
    [
      ["Kitap Oylayıcısı - I", 10],
      ["Kitap Oylayıcısı - II", 20],
      ["Kitap Oylayıcısı - III", 30],
      ["Kitap Oylayıcısı - IV", 40],
      ["Kitap Oylayıcısı - V", 50],
      ["Kitap Oylayıcısı - VI", 60],
      ["Kitap Oylayıcısı - VII", 70],
      ["Kitap Oylayıcısı - VIII", 80],
      ["Kitap Oylayıcısı - IX", 90],
      ["Kitap Oylayıcısı - X", 100],
    ],
    [
      ["Kitap Kaydedicisi - I", 10],
      ["Kitap Kaydedicisi - II", 20],
      ["Kitap Kaydeicisi - III", 30],
      ["Kitap Kaydeicisi - IV", 40],
      ["Kitap Kaydeicisi - V", 50],
      ["Kitap Kaydeicisi - VI", 60],
      ["Kitap Kaydeicisi - VII", 70],
      ["Kitap Kaydeicisi - VIII", 80],
      ["Kitap Kaydeicisi - IX", 90],
      ["Kitap Kaydeicisi - X", 100],
    ],
    [
      ["BookDB - I", 100],
      ["BookDB - II", 200],
      ["BookDB - III", 300],
      ["BookDB - IV", 400],
      ["BookDB - V", 500],
      ["BookDB - VI", 600],
      ["BookDB - VII", 700],
      ["BookDB - VIII", 800],
      ["BookDB - IX", 900],
      ["BookDB - X", 1000],
    ],
  ];
  final uid = Auth().currentUser?.uid;

  Future<int> saveCount() async {
    final _booksQuery = FirebaseFirestore.instance
        .collection('books')
        .where('save', arrayContains: uid);
    final QuerySnapshot snapshot = await _booksQuery.get();
    return snapshot.docs.length;
  }

  Future<int> ratingCount() async {
    int count = 0;
    final _booksQuery = await FirebaseFirestore.instance
        .collection('books')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        DocumentSnapshot documentSnapshot = doc;
        Map<String, dynamic> ratingMap = documentSnapshot["rating"];
        if (ratingMap.containsKey(uid)) {
          count++;
        }
      });
    });

    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Auth().currentUser != null
        ? FutureBuilder(
            future: saveCount(),
            builder: (context, snapshot) {
              final int saveCount = snapshot.data ?? 0;

              var sidx = 0;
              for (int i = 0; i < 10; i++) {
                if (int.parse(achievements[1][i][1].toString()) >= saveCount) {
                  if (int.parse(achievements[1][i][1].toString()) ==
                          saveCount &&
                      i < 2)
                    sidx = i + 1;
                  else
                    sidx = i;
                  break;
                }
              }
              return FutureBuilder(
                  future: ratingCount(),
                  builder: (context, snapshot) {
                    final int ratingCount = snapshot.data ?? 0;

                    var ridx = 0;
                    for (int i = 0; i < 10; i++) {
                      if (int.parse(achievements[0][i][1].toString()) >=
                          ratingCount) {
                        if (int.parse(achievements[0][i][1].toString()) ==
                                ratingCount &&
                            i < 2)
                          ridx = i + 1;
                        else
                          ridx = i;
                        break;
                      }
                    }

                    double rp = ratingCount < 30
                        ? (1 / 10) * (ratingCount - ridx * 10)
                        : 1;
                    double sp =
                        saveCount < 30 ? (1 / 10) * (saveCount - sidx * 10) : 1;
                    int point = saveCount * 1 + ratingCount * 3;
                    var pidx = 0;
                    for (int i = 0; i < 10; i++) {
                      if (int.parse(achievements[2][i][1].toString()) >=
                          point) {
                        if (int.parse(achievements[2][i][1].toString()) ==
                                point &&
                            i < 2)
                          pidx = i + 1;
                        else
                          pidx = i;
                        break;
                      }
                    }
                    return ListView(
                      children: [
                        ListTile(
                          leading: Icon(MdiIcons.starThreePoints, color: Colors.white,),
                          title: Text(
                            achievements[2][pidx][0].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
                          ),
                          subtitle: Text("$point Puan", style: TextStyle(color: Colors.white),),
                        ),
                        Divider(),
                        AchievementListItem(
                          progress: rp,
                          title: achievements[0][ridx][0].toString(),
                          subtitle: ratingCount <
                                  int.parse(achievements[0][2][1].toString())
                              ? '$ratingCount/' +
                                  achievements[0][ridx][1].toString() +
                                  " Kitap oylandı"
                              : "$ratingCount Kitap oylandı",
                        ),
                        Divider(),
                        AchievementListItem(
                          progress: sp,
                          title: achievements[1][sidx][0].toString(),
                          subtitle: saveCount <
                                  int.parse(achievements[1][2][1].toString())
                              ? '$saveCount/' +
                                  achievements[1][sidx][1].toString() +
                                  " Kitap kaydedildi"
                              : "$saveCount Kitap kaydedildi",
                        ),
                        Divider(),
                      ],
                    );
                  });
            })
        : Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Column(
                children: [
                  Icon(
                    Icons.lock,
                    size: 64,
                    color: Colors.white,
                  ),
                  Text(
                    "Başarılarım kısmını görüntüleyebilmek için giriş yapmalısınız",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
  }
}

class AchievementListItem extends StatelessWidget {
  final double progress;
  final String title;
  final String subtitle;

  const AchievementListItem({
    Key? key,
    required this.progress,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(MdiIcons.trophyAward, color: Colors.white,),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
      ),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.white),),
      trailing: CircularProgressBar(progress: progress),
    );
  }
}

class CircularProgressBar extends StatelessWidget {
  final double progress;

  const CircularProgressBar({Key? key, required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        value: progress,
        color: Color.fromRGBO(255, 255, 240, 1),
      ),
    );
  }
}
