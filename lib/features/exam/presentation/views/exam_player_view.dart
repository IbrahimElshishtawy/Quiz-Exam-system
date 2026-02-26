// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/exam_controller.dart';
import '../widgets/questions/mcq_question_widget.dart';
import '../../../../core/components/app_badge.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_routes.dart';

class ExamPlayerView extends StatefulWidget {
  const ExamPlayerView({super.key});

  @override
  State<ExamPlayerView> createState() => _ExamPlayerViewState();
}

class _ExamPlayerViewState extends State<ExamPlayerView> {
  final ExamController controller = Get.find<ExamController>();

  late final PageController _pageCtrl;

  // Demo: عدد الأسئلة
  final int _totalQuestions = 40;

  // حفظ الحالة محليًا (Demo)
  final RxSet<int> _answered = <int>{}.obs;
  final RxSet<int> _marked = <int>{}.obs;

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController(
      initialPage: controller.currentQuestionIndex.value,
    );
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (index < 0 || index >= _totalQuestions) return;
    controller.currentQuestionIndex.value = index;
    _pageCtrl.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  void _next() => _goTo(controller.currentQuestionIndex.value + 1);
  void _prev() => _goTo(controller.currentQuestionIndex.value - 1);

  void _toggleMark() {
    final i = controller.currentQuestionIndex.value;
    if (_marked.contains(i)) {
      _marked.remove(i);
    } else {
      _marked.add(i);
    }
  }

  void _markAnswered() {
    final i = controller.currentQuestionIndex.value;
    _answered.add(i);
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 700;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.grid_view_rounded),
          onPressed: () => _showQuestionPalette(context),
          tooltip: 'Question palette',
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Text(
                _formatTime(controller.remainingTime.value),
                style: TextStyle(
                  color:
                      controller.remainingTime.value < 300
                          ? AppColors.error
                          : null,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 2),
            const Text('Time Remaining', style: TextStyle(fontSize: 10)),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Center(
              child: Obx(
                () => AppBadge(
                  label: _answered.isEmpty ? 'Not saved' : 'Saved',
                  color:
                      _answered.isEmpty ? AppColors.warning : AppColors.success,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => _showSubmitConfirmation(context),
            icon: const Icon(Icons.check_circle, color: AppColors.success),
            tooltip: 'Submit',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress
            Obx(() {
              final current = controller.currentQuestionIndex.value + 1;
              final progress = current / _totalQuestions;
              return Column(
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.withOpacity(0.12),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(
                      children: [
                        Text(
                          'Question $current of $_totalQuestions',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Obx(() {
                          final answered = _answered.length;
                          final marked = _marked.length;
                          return Text(
                            'Answered: $answered • Marked: $marked',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.55),
                            ),
                          );
                        }),
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
                    controller: _pageCtrl,
                    physics:
                        const NeverScrollableScrollPhysics(), // تحكم كامل من الأسهم
                    onPageChanged:
                        (idx) => controller.currentQuestionIndex.value = idx,
                    itemCount: _totalQuestions,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: isWide ? 24 : 16,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _QuestionHeader(
                              index: index,
                              total: _totalQuestions,
                              isMarked: _marked.contains(index),
                              isAnswered: _answered.contains(index),
                            ),
                            const SizedBox(height: 12),

                            // السؤال (Demo)
                            McqQuestionWidget(
                              question:
                                  'What is the primary purpose of a "Garbage Collector" in programming languages like Java or C#?',
                              options: const [
                                'To delete unused files from the hard drive',
                                'To automatically manage memory by reclaiming unused objects',
                                'To optimize the speed of the CPU',
                                'To encrypt sensitive data in memory',
                              ],
                              onSelected: (val) {
                                _markAnswered();
                              },
                            ),

                            const SizedBox(height: 16),

                            // Actions row
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: _toggleMark,
                                  icon: Obx(() {
                                    final marked = _marked.contains(
                                      controller.currentQuestionIndex.value,
                                    );
                                    return Icon(
                                      marked ? Icons.flag : Icons.flag_outlined,
                                    );
                                  }),
                                  label: Obx(() {
                                    final marked = _marked.contains(
                                      controller.currentQuestionIndex.value,
                                    );
                                    return Text(
                                      marked ? 'Unmark' : 'Mark for review',
                                    );
                                  }),
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                ),
                                OutlinedButton.icon(
                                  onPressed:
                                      () => _showQuestionPalette(context),
                                  icon: const Icon(Icons.grid_view_rounded),
                                  label: const Text('Palette'),
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            _NavigationFooter(
              onPrev: _prev,
              onNext: _next,
              onSubmit: () => _showSubmitConfirmation(context),
              canPrev: controller.currentQuestionIndex.value > 0,
              canNext:
                  controller.currentQuestionIndex.value < _totalQuestions - 1,
              currentIndexRx: controller.currentQuestionIndex,
            ),
          ],
        ),
      ),
    );
  }

  void _showQuestionPalette(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.62,
          maxChildSize: 0.92,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question Palette',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _PaletteLegend(),
                  const SizedBox(height: 14),

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
                        itemCount: _totalQuestions,
                        itemBuilder: (context, index) {
                          final isAnswered = _answered.contains(index);
                          final isMarked = _marked.contains(index);
                          final isCurrent = index == current;

                          Color bg;
                          Color border;
                          Color textColor;

                          if (isCurrent) {
                            bg = AppColors.primary;
                            border = AppColors.primary;
                            textColor = Colors.white;
                          } else if (isMarked) {
                            bg = AppColors.warning;
                            border = AppColors.warning;
                            textColor = Colors.white;
                          } else if (isAnswered) {
                            bg = AppColors.primary.withOpacity(0.10);
                            border = AppColors.primary.withOpacity(0.35);
                            textColor = Theme.of(context).colorScheme.onSurface;
                          } else {
                            bg = Colors.transparent;
                            border = Colors.grey.shade300;
                            textColor = Theme.of(context).colorScheme.onSurface;
                          }

                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Get.back();
                              _goTo(index);
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
                                    color: textColor,
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

  void _showSubmitConfirmation(BuildContext context) {
    final answered = _answered.length;
    final marked = _marked.length;

    Get.dialog(
      AlertDialog(
        title: const Text('Submit Exam?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have answered $answered out of $_totalQuestions questions.',
            ),
            const SizedBox(height: 8),
            if (marked > 0)
              Text(
                '$marked question(s) are still marked for review.',
                style: const TextStyle(color: AppColors.warning),
              )
            else
              Text(
                'No questions marked for review.',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.offNamed(Routes.EXAM_RESULT);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

/// ---------------- UI pieces ----------------

class _QuestionHeader extends StatelessWidget {
  const _QuestionHeader({
    required this.index,
    required this.total,
    required this.isMarked,
    required this.isAnswered,
  });

  final int index;
  final int total;
  final bool isMarked;
  final bool isAnswered;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.quiz_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${index + 1} of $total',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isAnswered ? 'Answered' : 'Not answered yet',
                    style: TextStyle(
                      color:
                          isAnswered
                              ? AppColors.success
                              : Colors.black.withOpacity(0.55),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (isMarked)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.warning,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Marked',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PaletteLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget item(Color color, String label, {bool outlined = false}) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: outlined ? Colors.transparent : color,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      );
    }

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        item(AppColors.primary, 'Current'),
        item(AppColors.primary.withOpacity(0.35), 'Answered', outlined: true),
        item(AppColors.warning, 'Marked'),
        item(Colors.grey.shade300, 'Not answered', outlined: true),
      ],
    );
  }
}

class _NavigationFooter extends StatelessWidget {
  const _NavigationFooter({
    required this.onPrev,
    required this.onNext,
    required this.onSubmit,
    required this.canPrev,
    required this.canNext,
    required this.currentIndexRx,
  });

  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onSubmit;
  final bool canPrev;
  final bool canNext;
  final RxInt currentIndexRx;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.06),
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.12))),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 46,
                child: OutlinedButton.icon(
                  onPressed: canPrev ? onPrev : null,
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
                  onPressed: canNext ? onNext : onSubmit,
                  icon: Icon(
                    canNext
                        ? Icons.arrow_forward_ios_rounded
                        : Icons.check_circle_outline,
                  ),
                  label: Obx(() {
                    final i = currentIndexRx.value + 1;
                    final text = canNext ? 'Next ($i)' : 'Submit';
                    return Text(text);
                  }),
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
  }
}
