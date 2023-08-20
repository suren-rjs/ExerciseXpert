import 'package:exercise_expert/service/secure_storage.dart';
import 'package:exercise_expert/view/home_screen/home_page.dart';
import 'package:exercise_expert/view/splash_screen/splash_loading_screen.dart';
import 'package:exercise_expert/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Widget currentScreen = const SplashLoadingScreen();

  @override
  void onInit() {
    super.onInit();
    navigateToHomeScreen();
  }

  navigateToHomeScreen() async {
    bool isFirstOpen = await secureStorage.get("flash") != '1';
    await Future.delayed(const Duration(seconds: 6));
    currentScreen = isFirstOpen ? const SplashScreen() : const HomePage();
    update();
  }
}
