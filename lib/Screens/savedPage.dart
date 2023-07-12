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
    return StreamBuilder(
        stream: _booksQuery.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Auth().currentUser?.uid != null ? ListView.builder(
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
                      title: Text(documentSnapshot["name"], style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent)),
                      subtitle: Text(documentSnapshot["author"], style: TextStyle(color: Colors.white),),
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
                          child: Container(child: Icon(Icons.bookmark, color: Color.fromRGBO(255, 255, 240, 1),))),
                    ),
                    
                  );
                
                }) : Center(
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
                              "Kaydedilenler kısmını görüntüleyebilmek için giriş yapmalısınız", style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
