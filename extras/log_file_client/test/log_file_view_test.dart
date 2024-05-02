import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:log_file_client/log_file_view.dart';
import 'package:log_file_client/main.dart';

void main() {
  testWidgets('onTileClicked should navigate to log file page',
      (WidgetTester tester) async {
    await tester.pumpWidget(onTileClicked());
    expect(find.text('$path Data'), findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(ListView), findsNothing);

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(GridView), findsOneWidget);

    // await tester.tap(find.text('Click Me'));
    // await tester.pumpAndSettle();

    // expect(find.text('Tank $mockPath Page'), findsOneWidget);
    // expect(find.byType(LogBodyDisplay), findsOneWidget);
  });
}
