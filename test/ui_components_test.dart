import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/core/components/app_button.dart';
import 'package:flutter_application_1/core/theme/app_theme.dart';

void main() {
  testWidgets('AppButton Style Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: Center(
            child: AppButton(
              text: 'Test Button',
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
