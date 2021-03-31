import 'package:flutter/material.dart';
import 'package:my_quiz_app/constants.dart';
import 'package:my_quiz_app/models/Questions.dart';


class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key key,
    @required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
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
