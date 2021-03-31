import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_quiz_app/constants.dart';
import 'package:my_quiz_app/controllers/question_controller.dart';
import 'package:my_quiz_app/models/Questions.dart';

import 'option.dart';

class AllOptionsCard extends StatelessWidget {
  const AllOptionsCard({
    Key key,
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
          SizedBox(height: kDefaultPadding / 2),
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,
              text: question.options[index],
              press: () => _controller.checkAns(question, index),
            ),
          ),
        ],
      ),
    );
  }
}
