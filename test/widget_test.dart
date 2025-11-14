import 'package:flutter_test/flutter_test.dart';
import 'package:kasir_app/main.dart';

void main() {
  testWidgets('App launches successfully', (tester) async {
    await tester.pumpWidget(MyApp());

    // Test hanya memastikan aplikasi tidak crash saat dijalankan
    expect(find.byType(MyApp), findsOneWidget);
  });
}
