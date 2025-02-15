import 'package:flutter/material.dart';

class DeviceUtils {
  static double getScreenHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}