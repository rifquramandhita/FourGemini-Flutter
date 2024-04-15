import 'package:flutter/material.dart';
import 'package:four_gemini/core/helper/global_helper.dart';

ThemeData AppTheme(BuildContext context) {
  return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.blue,
      appBarTheme: AppBarTheme(
        backgroundColor: GlobalHelper.getColorSchema(context).primary,
        titleTextStyle: GlobalHelper.getTextTheme(context).titleLarge?.copyWith(
            color: GlobalHelper.getColorSchema(context).onPrimary),
      ));
}
