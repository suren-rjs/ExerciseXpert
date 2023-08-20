import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashLoadingScreen extends StatelessWidget {
  const SplashLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData contextSize = MediaQuery.of(context);
    double scrHeight = contextSize.size.height;
    double scrWidth = contextSize.size.width;
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animations/splashLoading.json',
          width: scrWidth * 0.6,
          height: scrHeight * 0.025,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData contextSize = MediaQuery.of(context);
    double scrHeight = contextSize.size.height;
    double scrWidth = contextSize.size.width;
    return Center(
      child: Lottie.asset(
        'assets/animations/take_break.json',
        width: scrWidth * 0.6,
        height: scrHeight * 0.025,
        fit: BoxFit.cover,
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData contextSize = MediaQuery.of(context);
    double scrHeight = contextSize.size.height;
    double scrWidth = contextSize.size.width;
    return Center(
      child: Lottie.asset(
        'assets/animations/loading.json',
        width: scrWidth * 0.6,
        height: scrHeight * 0.025,
        fit: BoxFit.cover,
      ),
    );
  }
}
