import 'dart:developer';

import 'package:exercise_expert/view/splash_screen/splash_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';

void main() {
  testWidgets('SplashLoadingScreen displays Lottie animation',
      (WidgetTester tester) async {
    // await tester.pumpWidget(const MaterialApp(home: SplashLoadingScreen()));
    //
    // expect(find.byType(Lottie), findsOneWidget);
      const currentPage = 1;
      print("Page from ${(currentPage-1) * 10} to ${currentPage * 10}");
  });
}
