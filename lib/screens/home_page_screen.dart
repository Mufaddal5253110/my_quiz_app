import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:my_quiz_app/constants.dart';
import 'package:my_quiz_app/controllers/question_controller.dart';
import 'package:get/get.dart';
import 'package:my_quiz_app/widgets/alloptions.dart';
import 'package:my_quiz_app/widgets/progress_bar.dart';
import 'package:my_quiz_app/widgets/question_card.dart';

class HomePage extends StatelessWidget {
  // So that we have acccess our controller
  QuestionController _questionController = Get.put(QuestionController());
  QuestionController _optionsController = Get.put(QuestionController());
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
                        Expanded(
                          child: PageView.builder(
                            // Block swipe to next qn
                            physics: NeverScrollableScrollPhysics(),
                            controller: _questionController.pageController,
                            onPageChanged: _questionController.updateTheQnNum,
                            itemCount: _questionController.questions.length,
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
                  physics: NeverScrollableScrollPhysics(),
                  controller: _optionsController.optionspageController,
                  onPageChanged: _optionsController.updateTheQnNum,
                  itemCount: _optionsController.questions.length,
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
