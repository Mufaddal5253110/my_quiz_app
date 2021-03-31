import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:my_quiz_app/models/Questions.dart';
import 'package:my_quiz_app/screens/score_screen.dart';
// import 'package:quiz_app/screens/score/score_screen.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  AnimationController _animationController;
  Animation _animation;
  // so that we can access our animation outside
  Animation get animation => this._animation;

  // List<Question> _questions;

  PageController _pageController;
  PageController get pageController => this._pageController;
  PageController _optionspageController;
  PageController get optionspageController => this._optionspageController;

  // Future loadQuestions() async {
  //   QuerySnapshot qShot =
  //       await FirebaseFirestore.instance.collection('data').orderBy('id').get();
  //   print(qShot);
  //   print(qShot.docs);
  //   _questions = qShot.docs
  //       .map(
  //         (doc) => Question(
  //           id: doc.data()["id"],
  //           answer: doc.data()["answer_index"],
  //           options: doc.data()["options"],
  //           question: doc.data()["question"],
  //         ),
  //       )
  //       .toList();
  //   FirebaseFirestore.instance
  //       .collection('data')
  //       .orderBy('id')
  //       .snapshots()
  //       .listen((event) {
  //         event.d
  //       });
  // }

  List<Question> _questions = sample_data
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();
  List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  int _skippedQue = 0;
  int get skippedQue => this._skippedQue;

  int _correctAns;
  int get correctAns => this._correctAns;

  int _selectedAns = 0;
  int get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  RxInt _numOfCorrectAns = 0.obs;
  RxInt get numOfCorrectAns => this._numOfCorrectAns;

  RxInt _numOfWrongAns = 0.obs;
  RxInt get numOfWrongAns => this._numOfWrongAns;

  // int _numOfCorrectAns = 0;
  // int get numOfCorrectAns => this._numOfCorrectAns;

  // int _numOfWrongAns = 0;
  // int get numOfWrongAns => this._numOfWrongAns;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: Duration(seconds: 20), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn

    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    _optionspageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
    _optionspageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns)
      _numOfCorrectAns.value++;
    else
      _numOfWrongAns.value++;

    // It will stop the counter
    _animationController.stop();
    update();
    // nextQuestion();

    // // Once user select an ans after 3s it will go to the next qn
    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      if (!_isAnswered) _skippedQue++;
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
      _optionspageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to naviigate another page
      // Get.to(ScoreScreen());
      Get.to(() => ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
