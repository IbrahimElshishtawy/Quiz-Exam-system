import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/components/app_card.dart';

class McqQuestionWidget extends StatelessWidget {
  final String question;
  final List<String> options;
  final int? selectedIndex;
  final Function(int) onSelected;

  const McqQuestionWidget({
    super.key,
    required this.question,
    required this.options,
    this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 24),
        ...List.generate(options.length, (index) {
          final isSelected = selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              onTap: () => onSelected(index),
              color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : null,
              padding: EdgeInsets.zero,
              child: ListTile(
                leading: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                title: Text(options[index]),
                trailing: isSelected
                  ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
                  : null,
              ),
            ),
          );
        }),
      ],
    );
  }
}
