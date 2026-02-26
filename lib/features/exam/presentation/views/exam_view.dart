// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/exam_controller.dart';

class ExamView extends GetView<ExamController> {
  const ExamView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExamController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            'Exam - ${controller.remainingTime.value ~/ 60}:${(controller.remainingTime.value % 60).toString().padLeft(2, '0')}',
          ),
        ),
        actions: [
          IconButton(
            onPressed: controller.submitExam,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(value: 0.5), // Mock progress
          Expanded(
            child: PageView.builder(
              itemCount: 10,
              onPageChanged:
                  (idx) => controller.currentQuestionIndex.value = idx,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Question ${index + 1}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 20),
                      const Text('What is the capital of France?'),
                      const SizedBox(height: 10),
                      ListTile(
                        title: const Text('Paris'),
                        leading: Radio(
                          value: 1,
                          groupValue: 0,
                          onChanged: (val) {},
                        ),
                      ),
                      ListTile(
                        title: const Text('London'),
                        leading: Radio(
                          value: 2,
                          groupValue: 0,
                          onChanged: (val) {},
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
