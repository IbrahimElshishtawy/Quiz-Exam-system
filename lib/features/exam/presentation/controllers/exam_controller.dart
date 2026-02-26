import 'dart:async';
import 'package:get/get.dart';

class ExamController extends GetxController {
  var remainingTime = 3600.obs; // 1 hour in seconds
  var currentQuestionIndex = 0.obs;
  Timer? timer;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        t.cancel();
        submitExam();
      }
    });
  }

  void nextQuestion() {
    currentQuestionIndex.value++;
  }

  void submitExam() {
    // Submit logic
    Get.back();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
