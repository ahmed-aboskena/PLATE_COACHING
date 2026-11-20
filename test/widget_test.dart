import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plate_coaching/app/plate_app.dart';
import 'package:plate_coaching/app/screen_registry.dart';
import 'package:plate_coaching/state/coaching_state.dart';

void main() {
  Future<void> pumpApp(
    WidgetTester tester, {
    Size viewSize = const Size(360, 800),
  }) async {
    tester.view.physicalSize = viewSize;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(PlateApp(coachingState: CoachingState()));
  }

  testWidgets('all coaching routes render without phone-size overflow', (
    tester,
  ) async {
    await pumpApp(tester, viewSize: const Size(320, 720));
    expect(find.text('Online training'), findsOneWidget);

    expect(ScreenRegistry.screens.map((screen) => screen.id).toSet(), {
      '8A',
      '1D',
      '2D',
      '3D',
      '4D',
      'coach-train',
      'coach-bar',
      'coach-order',
      '5D',
      '6D',
      '7D',
      '8D',
      '9D',
      '10D',
    });

    for (final screen in ScreenRegistry.screens) {
      Navigator.of(tester.element(find.byType(Scaffold).first))
          .pushReplacementNamed(screen.route);
      await tester.pumpAndSettle();
      expect(find.byKey(ValueKey('screen-${screen.id}')), findsOneWidget);
      expect(tester.takeException(), isNull, reason: 'Screen ${screen.id}');
    }
  });

  testWidgets('member and coach navigation switch between coaching areas', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.tap(find.text('Coach'));
    await tester.pumpAndSettle();
    expect(find.text('Mohamed Ali'), findsOneWidget);

    Navigator.of(tester.element(find.byType(Scaffold).first))
        .pushReplacementNamed('/2D');
    await tester.pumpAndSettle();
    expect(find.text('Online training'), findsOneWidget);
  });

  testWidgets('booking supports selecting and confirming a voice session', (
    tester,
  ) async {
    await pumpApp(tester);
    Navigator.of(tester.element(find.byType(Scaffold).first)).pushNamed('/3D');
    await tester.pumpAndSettle();
    expect(find.text('Book a session'), findsOneWidget);

    await tester.tap(find.text('Voice').first);
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Confirm · Today'));
    await tester.pumpAndSettle();

    expect(find.text('Booked voice session · Today, 7:30 PM'), findsOneWidget);
  });

  testWidgets('customer coach screen keeps its own conversation history', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.tap(find.text('Coach'));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Nice work today. Add 2.5 kg next week if the last set felt easy.',
      ),
      findsOneWidget,
    );
    expect(find.text('My shoulder feels tight on incline.'), findsOneWidget);
    expect(find.text('▶ Form check · 0:24'), findsNothing);
  });

  testWidgets('plan editing and coach chat update local mock state', (
    tester,
  ) async {
    await pumpApp(tester);

    Navigator.of(tester.element(find.byType(Scaffold).first)).pushNamed('/6D');
    await tester.pumpAndSettle();
    expect(find.text('65 kg'), findsOneWidget);
    await tester.tap(find.byTooltip('Increase Bench Press'));
    await tester.pumpAndSettle();
    expect(find.text('67.5 kg'), findsOneWidget);
    await tester.tap(find.text('Send updated plan'));
    await tester.pumpAndSettle();
    expect(find.text('Updated plan sent to Ahmed'), findsOneWidget);

    Navigator.of(tester.element(find.byType(Scaffold).first)).pop();
    await tester.pumpAndSettle();
    Navigator.of(tester.element(find.byType(Scaffold).first)).pushNamed('/7D');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ahmed M.'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Plan looks good');
    await tester.tap(find.byTooltip('Send message'));
    await tester.pumpAndSettle();
    expect(find.text('Plan looks good'), findsOneWidget);
  });

  testWidgets('call controls and coach booking availability respond to taps', (
    tester,
  ) async {
    await pumpApp(tester);

    Navigator.of(tester.element(find.byType(Scaffold).first)).pushNamed('/1D');
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Turn camera off'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Turn camera on'), findsOneWidget);

    Navigator.of(tester.element(find.byType(Scaffold).first)).pop();
    await tester.pumpAndSettle();
    Navigator.of(tester.element(find.byType(Scaffold).first)).pushNamed('/9D');
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();
    expect(find.text('Bookings are paused'), findsOneWidget);
  });

  testWidgets('coach can reserve a bar order and track it across navigation', (
    tester,
  ) async {
    await pumpApp(tester);
    Navigator.of(tester.element(find.byType(Scaffold).first))
        .pushReplacementNamed('/4D');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Bar').last);
    await tester.pumpAndSettle();
    expect(find.text('Protein Shake'), findsOneWidget);

    await tester.tap(find.byTooltip('Add Protein Shake'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Reserve · EGP 70'), findsOneWidget);
    await tester.tap(find.textContaining('Reserve · EGP 70'));
    await tester.pumpAndSettle();

    expect(find.text('Order #214'), findsOneWidget);
    expect(find.text('EGP 70'), findsOneWidget);

    await tester.tap(find.text('Bar').last);
    await tester.pumpAndSettle();
    expect(find.text('Order #214 · Preparing'), findsOneWidget);
    await tester.tap(find.text('Track'));
    await tester.pumpAndSettle();
    expect(find.text('Protein Shake'), findsOneWidget);
  });

  testWidgets('coach Train opens a personal plan without coach selection', (
    tester,
  ) async {
    await pumpApp(tester);
    Navigator.of(tester.element(find.byType(Scaffold).first))
        .pushReplacementNamed('/4D');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Train'));
    await tester.pumpAndSettle();
    expect(find.text('My training'), findsOneWidget);
    expect(find.text('Pull · Back & arms'), findsOneWidget);
    expect(find.text('Choose a coach'), findsNothing);
  });
}
