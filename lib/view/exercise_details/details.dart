import 'package:exercise_expert/controller/data_controller.dart';
import 'package:exercise_expert/model/exercises.dart';
import 'package:exercise_expert/utils/utils.dart';
import 'package:exercise_expert/view/exercise_details/widgets/details_container.dart';
import 'package:exercise_expert/view/exercise_details/widgets/title_builder.dart';
import 'package:exercise_expert/view/splash_screen/splash_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseDetails extends StatefulWidget {
  const ExerciseDetails({super.key, required this.exerciseId});

  final String exerciseId;

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  Exercise? exercise;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<DataController>().getExerciseById(widget.exerciseId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<DataController>(
          init: Get.find<DataController>(),
          builder: (controller) {
            if (controller.isLoading) return const Loading();
            exercise = controller.exercise;
            if (exercise == null) return const NoDataScreen();
            return Column(
              children: [
                utils.customSpacer(context, 2),
                TitleBuilder(exercise: exercise),
                utils.customSpacer(context, 2),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    exercise?.gifUrl ?? "",
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset("assets/images/no-image.jpg"),
                    fit: BoxFit.contain,
                  ),
                ),
                utils.customSpacer(context, 2),
                DetailsContainer(exercise: exercise),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            );
          },
        ),
      ),
    );
  }
}
