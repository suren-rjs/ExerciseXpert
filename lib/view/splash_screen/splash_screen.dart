import 'package:avatar_glow/avatar_glow.dart';
import 'package:exercise_expert/service/secure_storage.dart';
import 'package:exercise_expert/utils/animation.dart';
import 'package:exercise_expert/utils/app_colors.dart';
import 'package:exercise_expert/utils/utils.dart';
import 'package:exercise_expert/view/home_screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  late double _scale;
  late AnimationController _controller;
  final apiKeyController = TextEditingController();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = appColors.white;
    _scale = 1 - _controller.value;
    var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: appColors.lavenderGrey80),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: color,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                utils.customSpacer(context, 4),
                AvatarGlow(
                  endRadius: 120,
                  duration: const Duration(seconds: 2),
                  glowColor: appColors.halfWhiteLavender,
                  repeat: true,
                  repeatPauseDuration: const Duration(seconds: 2),
                  startDelay: const Duration(seconds: 1),
                  child: Material(
                    elevation: 8.0,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: appColors.halfWhiteLavender,
                      radius: 60.0,
                      child: const CircleAvatar(
                        radius: 55.0,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                  ),
                ),
                utils.customSpacer(context, 2),
                DelayedAnimation(
                  delay: delayedAmount + 500,
                  child: Text(
                    "Your Fitness Journey Starts Here...",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: appColors.lavenderGrey80,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                utils.customSpacer(context, 0.5),
                DelayedAnimation(
                  delay: delayedAmount + 1500,
                  child: Text(
                    "Unlock Your Potential with Every Move !",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: appColors.lavenderGrey80,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                utils.customSpacer(context, 2),
                DelayedAnimation(
                  delay: delayedAmount + 2200,
                  child: GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      _controller.forward();
                    },
                    onTapUp: (TapUpDetails details) async {
                      _controller.reverse();
                      Navigator.pop(context);
                      await secureStorage.add("flash", '1');
                      Get.to(() => const HomePage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: TextField(
                        controller: apiKeyController,
                        decoration: InputDecoration(
                          labelText: 'Enter RapidAPI API key (Optional)',
                          border: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          errorBorder: outlineInputBorder,
                          disabledBorder: outlineInputBorder,
                          focusedErrorBorder: outlineInputBorder,
                        ),
                      ),
                    ),
                  ),
                ),
                utils.customSpacer(context, 4),
                DelayedAnimation(
                  delay: delayedAmount + 2200,
                  child: GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      _controller.forward();
                    },
                    onTapUp: (TapUpDetails details) async {
                      _controller.reverse();
                      Navigator.pop(context);
                      await secureStorage.add("flash", '1');
                      await secureStorage.add(
                          "customApiKey",
                          apiKeyController.text.isEmpty
                              ? "none"
                              : apiKeyController.text);
                      Get.to(() => const HomePage());
                    },
                    child: Transform.scale(
                      scale: _scale,
                      child: _animatedButtonUI,
                    ),
                  ),
                ),
                utils.customSpacer(context, 0.5),
                DelayedAnimation(
                  delay: delayedAmount + 2200,
                  child: Text(
                    "Explore",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: appColors.lavenderGrey80,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: appColors.lavenderGrey80,
        ),
        child: Center(
          child: Icon(
            Icons.keyboard_arrow_right,
            color: appColors.white,
            size: 26,
          ),
        ),
      );
}
