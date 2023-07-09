import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import 'detailPage.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

void goDetialPage(context, book) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detailPage(book: book),
      ));
}

class _SavedPageState extends State<SavedPage> {
  bool _active = true;
  final uid = Auth().currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    final _booksQuery = FirebaseFirestore.instance
        .collection('books')
        .where('save', arrayContains: uid);
    return Auth().currentUser != null ? StreamBuilder(
        stream: _booksQuery.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return InkWell(
                    onTap: () {
                      goDetialPage(context, documentSnapshot);
                    },
                    child: ListTile(
                      leading: Image.network(
                        documentSnapshot["image"],
                        width: 50,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      title: Text(documentSnapshot["name"]),
                      subtitle: Text(documentSnapshot["author"]),
                      trailing: InkWell(
                          onTap: _active
                              ? () async {
                                  setState(() {
                                    _active = false;
                                  });
                                  List<dynamic> saveData =
                                      documentSnapshot["save"];
                                  saveData.remove(uid);

                                  await FirebaseFirestore.instance
                                      .collection("books")
                                      .doc(documentSnapshot.id)
                                      .update({"save": saveData});
                                  setState(() {
                                    _active = true;
                                  });
                                }
                              : null,
                          child: Icon(Icons.bookmark)),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }) : Center(child: Column(
          children: [
            Icon(Icons.lock, size: 64,),
            Text("Kaydedilenlerim kısmını görüntüleyebilmek için giriş yapmalısınız"),
          ],
        ),);
  }
}
