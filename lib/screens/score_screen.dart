import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:my_quiz_app/controllers/question_controller.dart';
import 'package:my_quiz_app/screens/home_page_screen.dart';

class ScoreScreen extends StatelessWidget {
  String getCompletionPoint(int quelength, int skippedquelen) {
    return ((((quelength - skippedquelen) / quelength) * 100).round())
            .toString() +
        "%";
  }

  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    final mqh = MediaQuery.of(context).size.height;
    final mqw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: null,
        ),
      ),
      body: Stack(
        children: [
          // WebsafeSvg.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: mqh * 0.50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white24,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white24,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Your Score",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  text:
                                      "${_qnController.numOfCorrectAns.value * 5}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "pt",
                                      style: TextStyle(fontSize: 14),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: mqh * 0.1, bottom: mqh * 0.05),
                alignment: Alignment.topCenter,
                width: mqw * 0.8,
                height: mqh * 0.22,
                child: Card(
                  elevation: 3,
                  child: GridView(
                    padding: EdgeInsets.all(12.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 55.0,
                      crossAxisSpacing: 20,
                    ),
                    children: [
                      pointinfo(
                        getCompletionPoint(_qnController.questions.length,
                            _qnController.skippedQue),
                        "Completaion",
                        Colors.purple,
                      ),
                      pointinfo(
                        "0${_qnController.questions.length}",
                        "Total Question",
                        Colors.purple,
                      ),
                      pointinfo(
                        "0${_qnController.numOfCorrectAns.value}",
                        "Correct",
                        Colors.green,
                      ),
                      pointinfo(
                        "0${_qnController.numOfWrongAns.value}",
                        "Wrong",
                        Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 100.0,
                  ),
                  children: <Widget>[
                    gridItem(Icons.refresh, "Play Again"),
                    gridItem(Icons.remove_red_eye_outlined, "Review Answer"),
                    gridItem(Icons.share, "Share Score"),
                    gridItem(Icons.file_download, "Generate PDF"),
                    gridItem(Icons.home, "Home"),
                    gridItem(Icons.leaderboard, "Leaderboard"),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget pointinfo(String point, String disc, Color clr) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            color: clr,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15),
            Text(
              point,
              style: TextStyle(
                color: clr,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.start,
            ),
            Text(
              disc,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget gridItem(IconData icon, String title) {
    return InkWell(
      child: Container(
        child: Column(
          children: <Widget>[Icon(icon), Text(title)],
        ),
      ),
    );
  }
}
