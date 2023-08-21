import 'package:exercise_expert/controller/data_controller.dart';
import 'package:exercise_expert/utils/app_colors.dart';
import 'package:exercise_expert/view/splash_screen/splash_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  bool isButtonClicked = false;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    isButtonClicked = false;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData contextSize = MediaQuery.of(context);
    double scrHeight = contextSize.size.height;
    double scrWidth = contextSize.size.width;
    return GetBuilder<DataController>(
      init: Get.find<DataController>(),
      builder: (controller) {
        if (controller.isLoading) return const Loading();
        return Column(
          children: [
            const Spacer(),
            Center(
              child: Image.asset(
                'assets/images/no-internet.gif',
                width: scrWidth * 1,
                height: scrHeight * 0.5,
                fit: BoxFit.contain,
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await handleConnection(controller);
                },
                child: Text(
                  "Retry !",
                  style: TextStyle(
                    fontSize: 20,
                    color: appColors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButtonClicked
                      ? appColors.smokeyWhite
                      : appColors.lavenderGrey80,
                  elevation: 0,
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                "Check your internet connectivity !",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: appColors.black20,
                ),
              ),
            ),
            const Spacer(),
          ],
        );
      },
    );
  }

  Future<void> handleConnection(DataController controller) async {
    if(isButtonClicked) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_disposed) return;
      setState(() => isButtonClicked = true);
    });
    controller.updateExercises();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(
        const Duration(seconds: 20),
        () {
          if (_disposed) return;
          setState(() => isButtonClicked = false);
        },
      );
    });
  }
}
