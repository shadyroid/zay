import 'package:flutter_test/flutter_test.dart';
import 'package:hedma/main.dart';

void main() {
  testWidgets('HedmaApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const HedmaApp());
    expect(find.text('Hedma'), findsOneWidget);
  });
}
