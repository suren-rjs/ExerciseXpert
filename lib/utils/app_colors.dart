// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

_AppColors appColors = _AppColors.instance;

class _AppColors {
  _AppColors._();

  static final _AppColors instance = _AppColors._();

  final Color black20 = const Color(0x33000000);
  final Color transparent = const Color(0x00ffffff);
  final Color white = const Color(0xFFFFFFFF);
  final Color half50 = const Color(0x80FFFFFF);
  final Color smokeyWhite = const Color(0xFFA49F9F);
  final Color halfWhiteLavender = const Color(0xFFAB8BB6);
  final Color appBackground = const Color(0xFFFFF7F7);
  final Color lavenderGrey80 = const Color(0xDE403949);
}
