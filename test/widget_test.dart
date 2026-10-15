import 'package:flutter_test/flutter_test.dart';
import 'package:unitpro_studio/main.dart';

void main() {
  testWidgets('App renders converter screen', (tester) async {
    await tester.pumpWidget(const UnitProApp(themeIndex: 0));
    expect(find.text('UnitPro Studio'), findsOneWidget);
  });
}
