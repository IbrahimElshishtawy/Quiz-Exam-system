import 'package:flutter/material.dart';

class CustomDotIndicator extends StatelessWidget {
  final int pageCount;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;

  const CustomDotIndicator({
    super.key,
    required this.pageCount,
    required this.currentIndex,
    this.activeColor = const Color(0xFF005BBF),
    this.inactiveColor = const Color(0xFFCBD5E1), // Cool grey-300
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        final bool isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: isActive ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      }),
    );
  }
}
