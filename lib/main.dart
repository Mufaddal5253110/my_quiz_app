import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz_app/models/Questions.dart';
import 'package:my_quiz_app/screens/home_page_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
      navigatorKey: Get.key,
    );
    // return StreamBuilder(
    //     stream: FirebaseFirestore.instance
    //         .collection('data')
    //         .orderBy('id')
    //         .snapshots(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (!snapshot.hasData) {
    //         return Container();
    //       }

    //       final _list = snapshot.data.docs;
    //       print(_list);
    //       if (_list.length != 0) {
    //         for (int i = 0; i < _list.length; i++) {
    //           Question questions = Question(
    //             id: _list[i].data()["id"],
    //             answer: _list[i].data()["answer_index"],
    //             options: _list[i].data()["options"],
    //             question: _list[i].data()["question"],
    //           );
    //           sample_data.add(questions);
    //           print(sample_data);
    //         }
    //       } else {
    //         sample_data = [
    //           {
    //             "id": 1,
    //             "question":
    //                 "Flutter is an open-source UI software development kit created by ______",
    //             "options": ['Apple', 'Google', 'Facebook', 'Microsoft'],
    //             "answer_index": 1,
    //           },
    //           {
    //             "id": 2,
    //             "question": "When google release Flutter.",
    //             "options": ['Jun 2017', 'July 2017', 'May 2017', 'May 2018'],
    //             "answer_index": 2,
    //           },
    //           {
    //             "id": 3,
    //             "question":
    //                 "A memory location that holds a single letter or number.",
    //             "options": ['Double', 'Int', 'Char', 'Word'],
    //             "answer_index": 2,
    //           },
    //           {
    //             "id": 4,
    //             "question":
    //                 "What command do you use to output data to the screen?",
    //             "options": ['Cin', 'Count>>', 'Cout', 'Output>>'],
    //             "answer_index": 2,
    //           },
    //         ];
    //       }

    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         title: 'Flutter Demo',
    //         theme: ThemeData(
    //           primarySwatch: Colors.purple,
    //         ),
    //         home: HomePage(),
    //         navigatorKey: Get.key,
    //       );
    //     });
  }
}
