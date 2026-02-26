// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/exam_controller.dart';

class ExamView extends StatefulWidget {
  const ExamView({super.key});

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  // لو عندك Binding بيعمل put للـ ExamController، السطر ده هيلاقيه
  // لو مش موجود، هيعمله مرة واحدة هنا.
  late final ExamController controller;
  late final PageController pageController;

  // Demo data
  final int totalQuestions = 10;
  final List<String> questions = List.generate(
    10,
    (i) => 'What is the capital of France? (Q${i + 1})',
  );
  final List<List<String>> options = List.generate(
    10,
    (_) => const ['Paris', 'London', 'Berlin', 'Madrid'],
  );

  // حفظ الإجابات: questionIndex -> selectedOptionIndex
  final RxMap<int, int> answers = <int, int>{}.obs;

  @override
  void initState() {
    super.initState();
    controller =
        Get.isRegistered<ExamController>()
            ? Get.find<ExamController>()
            : Get.put(ExamController());

    pageController = PageController(
      initialPage: controller.currentQuestionIndex.value,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void goTo(int index) {
    if (index < 0 || index >= totalQuestions) return;
    controller.currentQuestionIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void next() => goTo(controller.currentQuestionIndex.value + 1);
  void prev() => goTo(controller.currentQuestionIndex.value - 1);

  double progressValue(int currentIndex) => (currentIndex + 1) / totalQuestions;

  String formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void submit() {
    final answeredCount = answers.length;
    final remaining = totalQuestions - answeredCount;

    Get.dialog(
      AlertDialog(
        title: const Text('Submit Exam?'),
        content: Text(
          remaining == 0
              ? 'You answered all questions.'
              : 'You answered $answeredCount / $totalQuestions.\n$remaining question(s) still unanswered.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              // لو عندك submitExam في الكنترولر استخدمه
              controller.submitExam();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void showPalette(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.55,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question Palette',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Obx(() {
                      final current = controller.currentQuestionIndex.value;
                      return GridView.builder(
                        controller: scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width < 420 ? 5 : 7,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: totalQuestions,
                        itemBuilder: (context, index) {
                          final isCurrent = index == current;
                          final isAnswered = answers.containsKey(index);

                          Color bg;
                          Color border;
                          Color txt;

                          if (isCurrent) {
                            bg = Theme.of(context).colorScheme.primary;
                            border = bg;
                            txt = Colors.white;
                          } else if (isAnswered) {
                            bg = Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.12);
                            border = Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.35);
                            txt = Theme.of(context).colorScheme.onSurface;
                          } else {
                            bg = Colors.transparent;
                            border = Colors.grey.shade300;
                            txt = Theme.of(context).colorScheme.onSurface;
                          }

                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Get.back();
                              goTo(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: bg,
                                border: Border.all(color: border),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: txt,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 700;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.grid_view_rounded),
          onPressed: () => showPalette(context),
          tooltip: 'Palette',
        ),
        title: Obx(() {
          final t = controller.remainingTime.value;
          final danger = t < 300; // آخر 5 دقايق
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                formatTime(t),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: danger ? Colors.red : null,
                ),
              ),
              const SizedBox(height: 2),
              const Text('Time Remaining', style: TextStyle(fontSize: 10)),
            ],
          );
        }),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: submit,
            icon: const Icon(Icons.check_circle_outline),
            tooltip: 'Submit',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress + counts
            Obx(() {
              final idx = controller.currentQuestionIndex.value;
              return Column(
                children: [
                  LinearProgressIndicator(
                    value: progressValue(idx),
                    backgroundColor: Colors.grey.withOpacity(0.12),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                    child: Row(
                      children: [
                        Text(
                          'Question ${idx + 1} / $totalQuestions',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        Obx(
                          () => Text(
                            'Answered: ${answers.length}',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.55),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),

            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: PageView.builder(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: totalQuestions,
                    onPageChanged:
                        (idx) => controller.currentQuestionIndex.value = idx,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: isWide ? 24 : 16,
                          vertical: 16,
                        ),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Obx(() {
                              final selected = answers[index]; // ممكن null
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Question ${index + 1}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.w900),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    questions[index],
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 14),
                                  ...List.generate(options[index].length, (
                                    optIndex,
                                  ) {
                                    final optText = options[index][optIndex];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        color:
                                            selected == optIndex
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withOpacity(0.10)
                                                : Colors.transparent,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color:
                                              selected == optIndex
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.45)
                                                  : Colors.grey.shade300,
                                        ),
                                      ),
                                      child: RadioListTile<int>(
                                        value: optIndex,
                                        groupValue: selected,
                                        onChanged: (val) {
                                          if (val == null) return;
                                          answers[index] = val;
                                        },
                                        title: Text(optText),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                      ),
                                    );
                                  }),
                                ],
                              );
                            }),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Footer navigation
            Obx(() {
              final idx = controller.currentQuestionIndex.value;
              final canPrev = idx > 0;
              final canNext = idx < totalQuestions - 1;

              return Container(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceVariant.withOpacity(0.06),
                  border: Border(
                    top: BorderSide(color: Colors.grey.withOpacity(0.12)),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: OutlinedButton.icon(
                            onPressed: canPrev ? prev : null,
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                            label: const Text('Previous'),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: ElevatedButton.icon(
                            onPressed: canNext ? next : submit,
                            icon: Icon(
                              canNext
                                  ? Icons.arrow_forward_ios_rounded
                                  : Icons.check_circle_outline,
                            ),
                            label: Text(canNext ? 'Next' : 'Submit'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
