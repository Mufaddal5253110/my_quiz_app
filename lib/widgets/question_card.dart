import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_quiz_app/constants.dart';
import 'package:my_quiz_app/controllers/question_controller.dart';
import 'package:my_quiz_app/models/Questions.dart';


class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key key,
    // it means we have to pass this
    @required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          Text(
            question.question,
          ),
        ],
      ),
    );
  }
}
