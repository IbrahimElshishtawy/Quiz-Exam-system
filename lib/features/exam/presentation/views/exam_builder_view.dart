import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';

class ExamBuilderView extends StatefulWidget {
  const ExamBuilderView({super.key});

  @override
  State<ExamBuilderView> createState() => _ExamBuilderViewState();
}

class _ExamBuilderViewState extends State<ExamBuilderView> {
  int _currentStep = 0;

  // Basics
  final _basicsFormKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;
  DateTime? _startDate;
  DateTime? _endDate;

  // Questions (demo numbers)
  int _mcqCount = 12;
  int _tfCount = 8;

  // Rules
  int _durationMinutes = 60;
  bool _shuffleQuestions = true;
  bool _showResultsImmediately = false;
  String _cooldown = 'None';

  // Security
  bool _oneDevicePolicy = true;
  bool _watermark = true;
  String _proctoringLevel = 'High';

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController();
    _descCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  bool get _isLastStep => _currentStep == 3;

  String _fmtDate(DateTime? d) {
    if (d == null) return 'Select date';
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final initial =
        isStart ? (_startDate ?? now) : (_endDate ?? _startDate ?? now);

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );

    if (picked == null) return;

    setState(() {
      if (isStart) {
        _startDate = picked;
        // لو النهاية قبل البداية، نظبطها
        if (_endDate != null && _endDate!.isBefore(_startDate!)) {
          _endDate = _startDate;
        }
      } else {
        _endDate = picked;
        // لو النهاية قبل البداية، نخليها زي البداية
        if (_startDate != null && _endDate!.isBefore(_startDate!)) {
          _endDate = _startDate;
        }
      }
    });
  }

  bool _validateCurrentStep() {
    if (_currentStep == 0) {
      final ok = _basicsFormKey.currentState?.validate() ?? false;
      if (!ok) return false;

      if (_startDate == null || _endDate == null) {
        Get.snackbar(
          'Missing dates',
          'Please select start and end dates',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    }
    return true;
  }

  void _onContinue() {
    if (!_validateCurrentStep()) return;

    if (_currentStep < 3) {
      setState(() => _currentStep++);
    } else {
      Get.back();
      Get.snackbar(
        'Success',
        'Exam created successfully',
        backgroundColor: AppColors.success,
        colorText: Colors.white,
      );
    }
  }

  void _onCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isWide = c.maxWidth >= 600;
        final stepperType =
            isWide ? StepperType.horizontal : StepperType.vertical;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Create New Exam'),
            centerTitle: false,
          ),
          body: SafeArea(
            child: Stepper(
              type: stepperType,
              currentStep: _currentStep,
              onStepContinue: _onContinue,
              onStepCancel: _onCancel,
              elevation: 0,
              controlsBuilder: (context, details) {
                final primaryLabel = _isLastStep ? 'Publish' : 'Next';

                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: ElevatedButton.icon(
                            onPressed: details.onStepContinue,
                            icon: Icon(
                              _isLastStep
                                  ? Icons.check_circle_outline
                                  : Icons.arrow_forward,
                            ),
                            label: Text(primaryLabel),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: OutlinedButton.icon(
                            onPressed: details.onStepCancel,
                            icon: const Icon(Icons.arrow_back),
                            label: Text(_currentStep == 0 ? 'Close' : 'Back'),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              steps: [
                Step(
                  title: const Text('Basics'),
                  isActive: _currentStep >= 0,
                  state:
                      _currentStep > 0 ? StepState.complete : StepState.indexed,
                  content: _BasicsStep(
                    formKey: _basicsFormKey,
                    titleCtrl: _titleCtrl,
                    descCtrl: _descCtrl,
                    startLabel: _fmtDate(_startDate),
                    endLabel: _fmtDate(_endDate),
                    onPickStart: () => _pickDate(isStart: true),
                    onPickEnd: () => _pickDate(isStart: false),
                  ),
                ),
                Step(
                  title: const Text('Questions'),
                  isActive: _currentStep >= 1,
                  state:
                      _currentStep > 1 ? StepState.complete : StepState.indexed,
                  content: _QuestionsStep(
                    mcqCount: _mcqCount,
                    tfCount: _tfCount,
                    onAddFromBank: () {
                      Get.snackbar(
                        'Coming soon',
                        'Question bank integration not wired yet',
                        backgroundColor: Colors.black87,
                        colorText: Colors.white,
                      );
                    },
                    onCreateCustom: () {
                      // مثال: تزود سؤالين كـ demo
                      setState(() => _mcqCount += 2);
                      Get.snackbar(
                        'Added',
                        '2 custom MCQ questions added (demo)',
                        backgroundColor: AppColors.primary,
                        colorText: Colors.white,
                      );
                    },
                  ),
                ),
                Step(
                  title: const Text('Rules'),
                  isActive: _currentStep >= 2,
                  state:
                      _currentStep > 2 ? StepState.complete : StepState.indexed,
                  content: _RulesStep(
                    durationMinutes: _durationMinutes,
                    onDurationChanged:
                        (v) => setState(() => _durationMinutes = v),
                    shuffleQuestions: _shuffleQuestions,
                    onShuffleChanged:
                        (v) => setState(() => _shuffleQuestions = v),
                    showResultsImmediately: _showResultsImmediately,
                    onShowResultsChanged:
                        (v) => setState(() => _showResultsImmediately = v),
                    cooldown: _cooldown,
                    onCooldownChanged: (v) => setState(() => _cooldown = v),
                  ),
                ),
                Step(
                  title: const Text('Security'),
                  isActive: _currentStep >= 3,
                  state:
                      _currentStep == 3 ? StepState.indexed : StepState.indexed,
                  content: _SecurityStep(
                    oneDevicePolicy: _oneDevicePolicy,
                    onOneDeviceChanged:
                        (v) => setState(() => _oneDevicePolicy = v),
                    watermark: _watermark,
                    onWatermarkChanged: (v) => setState(() => _watermark = v),
                    proctoringLevel: _proctoringLevel,
                    onProctoringChanged:
                        (v) => setState(() => _proctoringLevel = v),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// -------------------- Widgets (UI) --------------------

class _BasicsStep extends StatelessWidget {
  const _BasicsStep({
    required this.formKey,
    required this.titleCtrl,
    required this.descCtrl,
    required this.startLabel,
    required this.endLabel,
    required this.onPickStart,
    required this.onPickEnd,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleCtrl;
  final TextEditingController descCtrl;
  final String startLabel;
  final String endLabel;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;

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
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleCtrl,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Exam Title',
                  hintText: 'e.g. Midterm Computer Science',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                validator:
                    (v) =>
                        (v == null || v.trim().isEmpty)
                            ? 'Title is required'
                            : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descCtrl,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'e.g. Topics covered: Chapter 1-5',
                  prefixIcon: const Icon(Icons.description_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                validator:
                    (v) =>
                        (v == null || v.trim().isEmpty)
                            ? 'Description is required'
                            : null,
              ),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, c) {
                  final stacked = c.maxWidth < 420;

                  if (stacked) {
                    // ✅ موبايل: بدون Expanded
                    return Column(
                      children: [
                        _DateField(
                          label: 'Start Date',
                          value: startLabel,
                          onTap: onPickStart,
                        ),
                        const SizedBox(height: 12),
                        _DateField(
                          label: 'End Date',
                          value: endLabel,
                          onTap: onPickEnd,
                        ),
                      ],
                    );
                  }

                  // ✅ شاشات واسعة: Row + Expanded عادي
                  return Row(
                    children: [
                      Expanded(
                        child: _DateField(
                          label: 'Start Date',
                          value: startLabel,
                          onTap: onPickStart,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _DateField(
                          label: 'End Date',
                          value: endLabel,
                          onTap: onPickEnd,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.date_range_outlined),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(value),
      ),
    );
  }
}

class _QuestionsStep extends StatelessWidget {
  const _QuestionsStep({
    required this.mcqCount,
    required this.tfCount,
    required this.onAddFromBank,
    required this.onCreateCustom,
  });

  final int mcqCount;
  final int tfCount;
  final VoidCallback onAddFromBank;
  final VoidCallback onCreateCustom;

  @override
  Widget build(BuildContext context) {
    final total = mcqCount + tfCount;

    return Column(
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const Icon(Icons.quiz_outlined),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Selected: $total Questions ($mcqCount MCQ, $tfCount True/False)',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton.icon(
            onPressed: onAddFromBank,
            icon: const Icon(Icons.library_add_outlined),
            label: const Text('Add Questions from Bank'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton.icon(
            onPressed: onCreateCustom,
            icon: const Icon(Icons.add_circle_outline),
            label: const Text('Create Custom Questions'),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RulesStep extends StatelessWidget {
  const _RulesStep({
    required this.durationMinutes,
    required this.onDurationChanged,
    required this.shuffleQuestions,
    required this.onShuffleChanged,
    required this.showResultsImmediately,
    required this.onShowResultsChanged,
    required this.cooldown,
    required this.onCooldownChanged,
  });

  final int durationMinutes;
  final ValueChanged<int> onDurationChanged;

  final bool shuffleQuestions;
  final ValueChanged<bool> onShuffleChanged;

  final bool showResultsImmediately;
  final ValueChanged<bool> onShowResultsChanged;

  final String cooldown;
  final ValueChanged<String> onCooldownChanged;

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
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              value: durationMinutes,
              decoration: InputDecoration(
                labelText: 'Duration',
                prefixIcon: const Icon(Icons.timer_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              items:
                  const [15, 30, 45, 60, 90, 120]
                      .map(
                        (m) => DropdownMenuItem(
                          value: m,
                          child: Text('$m minutes'),
                        ),
                      )
                      .toList(),
              onChanged: (v) {
                if (v != null) onDurationChanged(v);
              },
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              value: shuffleQuestions,
              onChanged: onShuffleChanged,
              title: const Text('Shuffle Questions'),
              subtitle: const Text('Randomize the order of questions'),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              value: showResultsImmediately,
              onChanged: onShowResultsChanged,
              title: const Text('Show Results Immediately'),
              subtitle: const Text('Show the score as soon as student submits'),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: cooldown,
              decoration: InputDecoration(
                labelText: 'Cooldown Period',
                prefixIcon: const Icon(Icons.lock_clock_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              items:
                  const ['None', '5 min', '10 min', '30 min', '1 hour']
                      .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                      .toList(),
              onChanged: (v) {
                if (v != null) onCooldownChanged(v);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SecurityStep extends StatelessWidget {
  const _SecurityStep({
    required this.oneDevicePolicy,
    required this.onOneDeviceChanged,
    required this.watermark,
    required this.onWatermarkChanged,
    required this.proctoringLevel,
    required this.onProctoringChanged,
  });

  final bool oneDevicePolicy;
  final ValueChanged<bool> onOneDeviceChanged;

  final bool watermark;
  final ValueChanged<bool> onWatermarkChanged;

  final String proctoringLevel;
  final ValueChanged<String> onProctoringChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0,
          color: Colors.grey.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                SwitchListTile(
                  value: oneDevicePolicy,
                  onChanged: onOneDeviceChanged,
                  title: const Text('One Device Policy'),
                  subtitle: const Text(
                    'Prevent multiple devices for same student',
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                SwitchListTile(
                  value: watermark,
                  onChanged: onWatermarkChanged,
                  title: const Text('Watermark'),
                  subtitle: const Text('Show student identifier watermark'),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: proctoringLevel,
                  decoration: InputDecoration(
                    labelText: 'Proctoring Level',
                    prefixIcon: const Icon(Icons.shield_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  items:
                      const ['Low', 'Medium', 'High']
                          .map(
                            (v) => DropdownMenuItem(value: v, child: Text(v)),
                          )
                          .toList(),
                  onChanged: (v) {
                    if (v != null) onProctoringChanged(v);
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Text(
            'Review carefully before publishing. All changes are logged.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
}
