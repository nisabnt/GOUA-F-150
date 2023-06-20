import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage();


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "BookDb",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
        height: MediaQuery.of(context).size.height,
        color: Colors.grey.shade300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  getExpanded('book','Bilim & Kurgu','23 Kitap'),
                  getExpanded('books-stack-of-three','Macera','27 Kitap'),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  getExpanded('books','Edebiyat','45 Kitap'),
                  getExpanded('book-stack','Çocuk','17 Kitap'),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  getExpanded('book1','Gençlik','25 Kitap'),
                  getExpanded('book2','Roman','37 Kitap'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded getExpanded(String image, String mainText, String subText){
    return Expanded(
      child: Container(
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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "$subText",
              style: TextStyle(
                  fontSize: 13.0
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(left: 10.0,top: 10.0,right: 10.0,bottom: 10.0),
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
      ),
    );
  }
}