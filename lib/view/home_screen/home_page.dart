import 'package:exercise_expert/controller/data_controller.dart';
import 'package:exercise_expert/utils/utils.dart';
import 'package:exercise_expert/view/global_widgets/search_box.dart';
import 'package:exercise_expert/view/home_screen/widgets/body_parts_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GetBuilder<DataController>(
          init: Get.find<DataController>(),
          builder: (controller) {
            return WillPopScope(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    SearchBox(),
                    BodyPartsContainer(),
                  ],
                ),
              ),
              onWillPop: () async {
                try {
                  FocusManager.instance.primaryFocus?.unfocus();
                } catch (e) {
                  debugPrint("Exception : $e");
                }
                if (controller.searchController.text.isNotEmpty) {
                  controller.clear();
                  return false;
                } else {
                  return utils.backToExit(context);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
