import 'dart:developer';

import 'package:exercise_expert/controller/data_controller.dart';
import 'package:exercise_expert/view/home_screen/widgets/exercise_list.dart';
import 'package:exercise_expert/view/splash_screen/splash_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyPartsContainer extends StatelessWidget {
  const BodyPartsContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(
      init: Get.find<DataController>(),
      builder: (controller) {
        if (controller.isLoading) return const Loading();
        if (controller.filteredWorkouts.isEmpty) return const NoDataScreen();
        return SingleChildScrollView(
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              // child: ListView.builder(
              //   itemCount: controller.bodyParts.length,
              //   itemBuilder: (context, index) {
              //     List<Exercise> workouts = controller.filteredWorkouts
              //         .where((element) =>
              //             element.bodyPart == controller.bodyParts[index])
              //         .toList();
              //     return Padding(
              //       padding: const EdgeInsets.all(20),
              //       child: Column(
              //         children: [
              //           // Row(
              //           //   children: [
              //           //     Text(
              //           //       "${controller.bodyParts[index].toUpperCase()} ( ${workouts.length} ) ",
              //           //       style: TextStyle(
              //           //         fontSize: 20,
              //           //         fontWeight: FontWeight.bold,
              //           //         color: appColors.lavenderGrey80,
              //           //       ),
              //           //     ),
              //           //   ],
              //           // ),
              //           ExerciseContainer(
              //             bodyPart: controller.bodyParts[index],
              //             targetedWorkouts: workouts,
              //           ),
              //           // controller.bodyParts.length - 1 != index
              //           //     ? Divider(
              //           //         color: appColors.black20,
              //           //         height: 2,
              //           //         thickness: 1,
              //           //       )
              //           //     : Container()
              //         ],
              //       ),
              //     );
              //   },
              // ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ExerciseContainer(
                  // bodyPart: controller.bodyParts[index],
                  targetedWorkouts: controller.filteredWorkouts,
                ),
              )),
        );
      },
    );
  }
}
