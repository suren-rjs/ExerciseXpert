import 'package:exercise_expert/utils/app_colors.dart';
import 'package:exercise_expert/utils/utils.dart';
import 'package:flutter/material.dart';

class RichTextBuilder extends StatelessWidget {
  const RichTextBuilder({
    Key? key,
    required this.keyName,
    required this.value,
  }) : super(key: key);

  final String keyName;
  final String? value;

  @override
  Widget build(BuildContext context) {
    String notFound = "Not Found";
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: keyName,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: appColors.lavenderGrey80,
                  fontSize: 20,
                ),
              ),
              TextSpan(
                text: utils.capitalizeEveryWord(value ?? notFound),
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: appColors.lavenderGrey80,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
