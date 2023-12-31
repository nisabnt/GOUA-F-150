import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class RatingPage extends StatefulWidget {
  final book;
  const RatingPage({super.key, required this.book});

  @override
  State<RatingPage> createState() => _RatingPageState(book);
}

class _RatingPageState extends State<RatingPage> {
  final book;

  _RatingPageState(this.book);
  Widget header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.chevron_left_rounded,
              size: 30,
              color: Colors.white,
            )),
        Text(
          "Kitap Oy Oranı",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19, color: Colors.white),
        ),
        Opacity(opacity: 0.0, child: Icon(Icons.abc)),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> ratingData = book["rating"];
    var one = 0, two = 0, three = 0, four = 0, five = 0;
    ratingData.forEach((key, value) {
      
      if (int.parse(value) == 5)
        five++;
      else if (int.parse(value)  == 4)
        four++;
      else if (int.parse(value)  == 3)
        three++;
      else if (int.parse(value)  == 2)
        two++;
      else
        one++;
    });
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 33, 36, 1),
      body: Column(
        children: [
          SafeArea(child: header()),
          Expanded(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: SfSparkBarChart(
                      color: Colors.redAccent,
                      axisLineColor: Colors.redAccent,
                      data: [one,two,three,four,five],
                      labelDisplayMode: SparkChartLabelDisplayMode.all,
                      labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("1", style: TextStyle(color: Colors.white),),
                        Text("2",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text("3",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text("4",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text("5",
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
