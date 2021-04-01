import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz_app/controllers/question_controller.dart';
import 'package:my_quiz_app/models/Questions.dart';
import 'package:my_quiz_app/screens/home_page_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<Question> _questions = [];
  QuestionController _questionController = Get.put(QuestionController());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('data')
            .orderBy('id')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.purple,
              ),
              home: Center(
                child: CircularProgressIndicator(),
              ),
              // navigatorKey: Get.key,
            );
          } else {
            if (!snapshot.hasData) {
              return Container();
            }
            final _list = snapshot.data.docs;
            print(_list[0].data());
            if (_list.length != 0) {
              for (int i = 0; i < _list.length; i++) {
                Question questions = Question(
                  id: _list[i].data()["id"],
                  answer: _list[i].data()["answer_index"],
                  options: _list[i].data()["options"],
                  question: _list[i].data()["question"],
                );
                _questions.add(questions);
              }
              _questionController.setQuestions(_questions);
            }
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            home: HomePage(),
            navigatorKey: Get.key,
          );
        });
  }
}
