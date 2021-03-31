import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:my_quiz_app/constants.dart';
import 'package:my_quiz_app/controllers/question_controller.dart';
import 'package:get/get.dart';
import 'package:my_quiz_app/models/Questions.dart';
import 'package:my_quiz_app/widgets/alloptions.dart';
import 'package:my_quiz_app/widgets/progress_bar.dart';
import 'package:my_quiz_app/widgets/question_card.dart';

class HomePage extends StatefulWidget {
  // So that we have acccess our controller
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QuestionController _questionController = Get.put(QuestionController());

  QuestionController _optionsController = Get.put(QuestionController());

  // Future loadQue() async {
  //   QuerySnapshot qShot =
  //       await FirebaseFirestore.instance.collection('data').orderBy('id').get();
  //   print(qShot);
  //   print(qShot.docs);
  //   sample_data = qShot.docs
  //       .map((doc) => {
  //                 "id": doc.data()["id"],
  //                 "question": doc.data()["question"],
  //                 "options": doc.data()["options"],
  //                 "answer_index": doc.data()["answer_index"],
  //               }
  //           // Question(
  //           //   id: doc.data()["id"],
  //           //   answer: doc.data()["answer_index"],
  //           //   options: doc.data()["options"],
  //           //   question: doc.data()["question"],
  //           // ),
  //           )
  //       .toList();
  //   // Stream<QuerySnapshot> stream =
  //   //   FirebaseFirestore.instance.collection('data').orderBy('id').snapshots();

  //   // sample_data = stream.map(
  //   //   (qShot) => qShot.docs.map(
  //   //     (doc) =>Question(
  //   //           id: doc.data()["id"],
  //   //           answer: doc.data()["answer_index"],
  //   //           options: doc.data()["options"],
  //   //           question: doc.data()["question"],
  //   //         )
  //   //   ).toList();
  //   // final _list = snapshots;
  //   //       print(_list);
  //   //       if (_list.length != 0) {
  //   //         for (int i = 0; i < _list.length; i++) {
  //   //           Question questions = Question(
  //   //             id: _list[i].data()["id"],
  //   //             answer: _list[i].data()["answer_index"],
  //   //             options: _list[i].data()["options"],
  //   //             question: _list[i].data()["question"],
  //   //           );
  //   //           sample_data.add(questions);
  //   //           print(sample_data);
  //   //         }
  //   //       }
  // }

  // @override
  // void initState() {
  //   // Stream<QuerySnapshot> snapshots =

  //   super.initState();
  //   // _questionController.loadQuestions();
  // }

  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: null,
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: mqh * 0.30,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ProgressBar(),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Card(
                  elevation: 3,
                  margin: EdgeInsets.only(top: mqh * 0.10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: mqw * 0.8,
                    height: mqh * 0.22,
                    child: Column(
                      children: <Widget>[
                        // Text("Questions 13/20"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Obx(
                              () => Text(
                                "${_questionController.numOfCorrectAns.value}",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Obx(
                              () => Text(
                                "${_questionController.numOfWrongAns.value}",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => Text.rich(
                            TextSpan(
                              text:
                                  "Question ${_questionController.questionNumber.value}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                              children: [
                                TextSpan(
                                  text:
                                      "/${_questionController.questions.length}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Text(
                        //   "How many Students in your class __ from India",
                        //   maxLines: 3,
                        //   textAlign: TextAlign.center,
                        // )
                        Expanded(
                          child: PageView.builder(
                            // Block swipe to next qn
                            physics: NeverScrollableScrollPhysics(),
                            controller: _questionController.pageController,
                            onPageChanged: _questionController.updateTheQnNum,
                            itemCount:
                                _questionController.questions == null
                                    ? 0
                                    : _questionController.questions.length,
                            itemBuilder: (context, index) => QuestionCard(
                                question: _questionController.questions[index]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  // Block swipe to next qn
                  physics: NeverScrollableScrollPhysics(),
                  controller: _optionsController.optionspageController,
                  onPageChanged: _optionsController.updateTheQnNum,
                  itemCount: _optionsController.questions == null
                      ? 0
                      : _optionsController.questions.length,
                  itemBuilder: (context, index) => AllOptionsCard(
                      question: _optionsController.questions[index]),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
