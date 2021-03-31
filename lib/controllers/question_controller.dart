import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:my_quiz_app/models/Questions.dart';
import 'package:my_quiz_app/screens/score_screen.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  AnimationController _animationController;
  Animation _animation;
  // so that we can access our animation outside
  Animation get animation => this._animation;

  PageController _pageController;
  PageController get pageController => this._pageController;
  PageController _optionspageController;
  PageController get optionspageController => this._optionspageController;

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

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  RxInt _numOfCorrectAns = 0.obs;
  RxInt get numOfCorrectAns => this._numOfCorrectAns;

  RxInt _numOfWrongAns = 0.obs;
  RxInt get numOfWrongAns => this._numOfWrongAns;

  @override
  void onInit() {
    // Our animation duration is 20 s
    // so our plan is to fill the progress bar within 20s
    _animationController =
        AnimationController(duration: Duration(seconds: 20), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    // start our animation
    // Once 20s is completed go to the next qn

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
      Get.to(() => ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
