// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/components/app_card.dart';

class McqQuestionWidget extends StatelessWidget {
  final String question;
  final List<String> options;

  /// index of selected option (0-based)
  final int? selectedIndex;

  /// optional: show "Question X" header
  final int? questionNumber;

  /// optional: total questions (to show "X / total")
  final int? totalQuestions;

  final ValueChanged<int> onSelected;

  const McqQuestionWidget({
    super.key,
    required this.question,
    required this.options,
    this.selectedIndex,
    this.questionNumber,
    this.totalQuestions,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final border = Colors.grey.shade300;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (questionNumber != null) ...[
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: primary.withOpacity(0.25)),
                ),
                child: Text(
                  totalQuestions == null
                      ? 'Question $questionNumber'
                      : 'Question $questionNumber / $totalQuestions',
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              if (selectedIndex != null)
                Row(
                  children: [
                    Icon(Icons.check_circle, size: 18, color: primary),
                    const SizedBox(width: 6),
                    Text(
                      'Selected',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withOpacity(0.55),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 10),
        ],

        Text(
          question,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w900,
            height: 1.25,
          ),
        ),

        const SizedBox(height: 16),

        ...List.generate(options.length, (index) {
          final isSelected = selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              onTap: () => onSelected(index),
              padding: EdgeInsets.zero,
              color: isSelected ? primary.withOpacity(0.08) : null,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? primary.withOpacity(0.45) : border,
                    width: 1,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  leading: _OptionLetter(
                    letter: String.fromCharCode(65 + index),
                    selected: isSelected,
                  ),
                  title: Text(
                    options[index],
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                  trailing: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    child:
                        isSelected
                            ? Icon(
                              Icons.check_circle,
                              key: const ValueKey('selected'),
                              color: primary,
                            )
                            : Icon(
                              Icons.circle_outlined,
                              key: const ValueKey('unselected'),
                              color: Colors.grey.shade500,
                            ),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _OptionLetter extends StatelessWidget {
  const _OptionLetter({required this.letter, required this.selected});

  final String letter;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: selected ? primary : Colors.grey.withOpacity(0.12),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
            color:
                selected
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
