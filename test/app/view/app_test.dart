import 'package:arrivo_task/app/app.dart';
import 'package:arrivo_task/app/post/view/post_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders PostPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(PostPage), findsOneWidget);
    });
  });
}
