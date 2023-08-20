import 'package:exercise_expert/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

_Utils utils = _Utils.instance;

class _Utils {
  _Utils._();

  static final _Utils instance = _Utils._();
  DateTime? _backButtonPressTime;

  String capitalizeEveryWord(String sentence) {
    if (sentence.isEmpty) {
      return sentence;
    }

    final words = sentence.split(RegExp(r'\s+'));

    final capitalizedWords = words.map((word) {
      try {
        return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
      } catch (e) {
        return '';
      }
    });

    return capitalizedWords.join(' ');
  }

  bool backToExit(BuildContext context) {
    final currentTime = DateTime.now();
    if (_backButtonPressTime == null ||
        currentTime.difference(_backButtonPressTime!) >
            const Duration(seconds: 2)) {
      _backButtonPressTime = currentTime;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Press back again to exit")),
      );
      return false;
    }
    return true;
  }

  SizedBox customSpacer(BuildContext context, double value) =>
      SizedBox(height: MediaQuery.of(context).size.height * 0.03 * value);

  void alertUser(String message) {
    Get.snackbar(
      "Alert !",
      message,
      animationDuration: const Duration(seconds: 2),
      duration: const Duration(seconds: 4),
      barBlur: 0.5,
      colorText: Colors.white,
      backgroundColor: appColors.lavenderGrey80,
      icon: const Icon(Icons.info),
    );
  }
}
