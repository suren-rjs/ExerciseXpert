import 'package:exercise_expert/model/exercises.dart';
import 'package:exercise_expert/utils/app_colors.dart';
import 'package:exercise_expert/utils/utils.dart';
import 'package:exercise_expert/view/exercise_details/details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseContainer extends StatelessWidget {
  const ExerciseContainer({
    Key? key,
    required this.bodyPart,
    required this.targetedWorkouts,
  }) : super(key: key);

  final String bodyPart;
  final List<Exercise> targetedWorkouts;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height:
          MediaQuery.of(context).size.height * 0.0765 * targetedWorkouts.length,
      child: ListView.builder(
        itemCount: targetedWorkouts.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: appColors.lavenderGrey80,
            ),
            title: Text(
              utils.capitalizeEveryWord(targetedWorkouts[index].name),
              style: TextStyle(
                color: appColors.lavenderGrey80,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Target : ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: appColors.lavenderGrey80,
                      ),
                    ),
                    TextSpan(
                      text: utils
                          .capitalizeEveryWord(targetedWorkouts[index].target),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: appColors.lavenderGrey80,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              Get.to(() =>
                  ExerciseDetails(exerciseId: targetedWorkouts[index].id));
            },
          );
        },
      ),
    );
  }
}
