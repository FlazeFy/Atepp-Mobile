// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:atepp/view/dashboard/index.dart';
import 'package:atepp/view/dummy/index.dart';
import 'package:atepp/view/global/index.dart';
import 'package:atepp/view/project/index.dart';
import 'package:atepp/view/workingspace/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:atepp/main.dart';

void main() {
  testWidgets('TC-W-001 Navigate navigation bar', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(
      signed: false,
    ));

    expect(find.text('Dashboard'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('dashboard_nav')));
    expect(find.byType(DashboardPage), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('project_nav')));
    await tester.pump();
    expect(find.byType(ProjectPage), findsOneWidget);
    expect(find.text('Project'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('workingspace_nav')));
    await tester.pump();
    expect(find.byType(WorkingSpace), findsOneWidget);
    expect(find.text('WorkingSpace'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('dummy_nav')));
    await tester.pump();
    expect(find.byType(DummyPage), findsOneWidget);
    expect(find.text('Global'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('global_nav')));
    await tester.pump();
    expect(find.byType(GlobalPage), findsOneWidget);
    expect(find.text('Global'), findsOneWidget);
  });
}
