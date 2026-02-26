import 'package:flutter/material.dart';

class WatermarkOverlay extends StatelessWidget {
  final String text;
  const WatermarkOverlay({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Opacity(
          opacity: 0.1,
          child: Transform.rotate(
            angle: -0.5,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
