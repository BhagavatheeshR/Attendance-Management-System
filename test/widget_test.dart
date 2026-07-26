// Basic smoke test: each flavor boots to its login screen with the
// correct role(s) offered.

import 'package:flutter_test/flutter_test.dart';

import 'package:attence/app/app.dart';
import 'package:attence/core/app_flavor.dart';

void main() {
  testWidgets('Admin flavor boots to login with only Administrator access', (WidgetTester tester) async {
    await tester.pumpWidget(const AttenceApp(flavor: AppFlavor.admin));
    await tester.pumpAndSettle();

    expect(find.text('Attence'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.textContaining('Administrator access'), findsOneWidget);
  });

  testWidgets('Staff/Student flavor boots to login with a role picker', (WidgetTester tester) async {
    await tester.pumpWidget(const AttenceApp(flavor: AppFlavor.staffStudent));
    await tester.pumpAndSettle();

    expect(find.text('Attence'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('I am signing in as'), findsOneWidget);
  });
}
