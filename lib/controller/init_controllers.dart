import 'package:exercise_expert/controller/data_controller.dart';
import 'package:exercise_expert/controller/splash_controller.dart';
import 'package:get/get.dart';

class InitControllers extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => DataController());
  }
}
