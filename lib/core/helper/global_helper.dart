import 'package:flutter/material.dart';

class GlobalHelper {
  static TextTheme getTextTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  static ColorScheme getColorSchema(BuildContext context){
    return Theme.of(context).colorScheme;
  }
}
