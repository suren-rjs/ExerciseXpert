import 'package:exercise_expert/model/exercises.dart';
import 'package:exercise_expert/utils/utils.dart';
import 'package:exercise_expert/view/exercise_details/widgets/rich_text_builder.dart';
import 'package:flutter/material.dart';

class DetailsContainer extends StatelessWidget {
  const DetailsContainer({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  final Exercise? exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichTextBuilder(
              keyName: 'Body Part : ',
              value: exercise?.bodyPart,
            ),
            utils.customSpacer(context, 1),
            RichTextBuilder(
              keyName: 'Target : ',
              value: exercise?.target,
            ),
            utils.customSpacer(context, 1),
            RichTextBuilder(
              keyName: 'Equipment : ',
              value: exercise?.equipment,
            ),
          ],
        ),
      ),
    );
  }
}
