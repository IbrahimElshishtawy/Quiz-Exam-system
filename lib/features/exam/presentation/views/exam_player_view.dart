// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/exam_controller.dart';
import '../widgets/questions/mcq_question_widget.dart';
import '../../../../core/components/app_badge.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_routes.dart';

class ExamPlayerView extends GetView<ExamController> {
  const ExamPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.grid_view_rounded),
          onPressed: () => _showQuestionPalette(context),
        ),
        title: Column(
          children: [
            Obx(
              () => Text(
                _formatTime(controller.remainingTime.value),
                style: TextStyle(
                  color:
                      controller.remainingTime.value < 300
                          ? AppColors.error
                          : null,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text('Time Remaining', style: TextStyle(fontSize: 10)),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: const Center(
              child: AppBadge(label: 'Saved', color: AppColors.success),
            ),
          ),
          IconButton(
            onPressed: () => _showSubmitConfirmation(context),
            icon: const Icon(Icons.check_circle, color: AppColors.success),
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(
            () => LinearProgressIndicator(
              value: (controller.currentQuestionIndex.value + 1) / 40,
              backgroundColor: Colors.grey.withOpacity(0.1),
            ),
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged:
                  (idx) => controller.currentQuestionIndex.value = idx,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: McqQuestionWidget(
                    question:
                        'What is the primary purpose of a "Garbage Collector" in programming languages like Java or C#?',
                    options: [
                      'To delete unused files from the hard drive',
                      'To automatically manage memory by reclaiming unused objects',
                      'To optimize the speed of the CPU',
                      'To encrypt sensitive data in memory',
                    ],
                    onSelected: (val) {},
                  ),
                );
              },
            ),
          ),
          _buildNavigationFooter(context),
        ],
      ),
    );
  }

  Widget _buildNavigationFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.05),
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.1))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.flag_outlined),
            label: const Text('Mark for Review'),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(width: 8),
              Obx(
                () => Text(
                  'Question ${controller.currentQuestionIndex.value + 1} of 40',
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: controller.nextQuestion,
                icon: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showQuestionPalette(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.6,
            maxChildSize: 0.9,
            expand: false,
            builder:
                (context, scrollController) => Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Question Palette',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                              ),
                          itemCount: 40,
                          itemBuilder: (context, index) {
                            bool isAnswered = index < 5;
                            bool isMarked = index == 7;
                            bool isCurrent = index == 0;

                            return GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      isCurrent
                                          ? AppColors.primary
                                          : (isMarked
                                              ? AppColors.warning
                                              : (isAnswered
                                                  ? AppColors.primary
                                                      .withOpacity(0.1)
                                                  : Colors.transparent)),
                                  border: Border.all(
                                    color:
                                        isCurrent
                                            ? AppColors.primary
                                            : Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color:
                                          isCurrent
                                              ? Colors.white
                                              : (isMarked
                                                  ? Colors.white
                                                  : Theme.of(
                                                    context,
                                                  ).colorScheme.onSurface),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  void _showSubmitConfirmation(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Submit Exam?'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You have answered 35 out of 40 questions.'),
            SizedBox(height: 8),
            Text(
              '5 questions are still marked for review.',
              style: TextStyle(color: AppColors.warning),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Get.offNamed(Routes.EXAM_RESULT),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
