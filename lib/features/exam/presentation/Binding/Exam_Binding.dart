// ignore_for_file: file_names

import 'package:flutter_application_1/features/exam/presentation/controllers/exam_controller.dart';
import 'package:get/get.dart';

class ExamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExamController>(() => ExamController());
  }
}
