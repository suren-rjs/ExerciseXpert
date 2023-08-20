import 'package:exercise_expert/utils/app_colors.dart';
import 'package:exercise_expert/controller/init_controllers.dart';
import 'package:exercise_expert/controller/splash_controller.dart';
import 'package:exercise_expert/service/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await secureStorage.init();
  await secureStorage.getAll();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: '',
        visualDensity: VisualDensity.compact,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(background: appColors.appBackground),
      ),
      initialBinding: InitControllers(),
      home: const AppScreen(),
    );
  }
}

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: Get.put(SplashController()),
      builder: (controller) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.red,
              appBarTheme: const AppBarTheme(color: Colors.red)),
          home: controller.currentScreen,
        );
      },
    );
  }
}
