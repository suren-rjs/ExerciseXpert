import 'package:exercise_expert/model/exercises.dart';
import 'package:exercise_expert/utils/app_colors.dart';
import 'package:exercise_expert/utils/utils.dart';
import 'package:flutter/material.dart';

class TitleBuilder extends StatelessWidget {
  const TitleBuilder({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  final Exercise? exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
      child: Center(
        child: Text(
          utils.capitalizeEveryWord(exercise?.name ?? ""),
          style: TextStyle(
            fontSize: 30,
            color: appColors.lavenderGrey80,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
