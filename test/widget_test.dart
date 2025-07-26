import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shum/main.dart';

void main() {
  group('Shum App Tests', () {
    testWidgets('Counter increments smoke test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that our counter starts at 0.
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify that our counter has incremented.
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('App title is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify that the app title is displayed
      expect(find.text('Flutter Demo Home Page'), findsOneWidget);
    });

    testWidgets('Floating action button is present', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify that the floating action button is present
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('Counter text is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify that the counter text is displayed
      expect(find.text('You have pushed the button this many times:'), findsOneWidget);
    });
  });
} 