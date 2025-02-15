import 'package:country_api_hng_task_3/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// ThemeProvider class to manage theme state
class ThemeProvider with ChangeNotifier {
  // Initial theme data set to light theme
  ThemeData _themeData = AppTheme.lightTheme;
  
  // Getter for theme data
  ThemeData get themeData => _themeData;
  
  // Icons for light and dark themes
  Icon icon = Icon(Iconsax.sun_14);
  Icon iconDark = Icon(Iconsax.moon);

  // Setter for theme data with notification to listeners
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // Setter for light theme icon with notification to listeners
  set themeIcon(Icon icon) {
    this.icon = icon;
    notifyListeners();
  }

  // Setter for dark theme icon with notification to listeners
  set themeIconDark(Icon iconDark) {
    this.iconDark = iconDark;
    notifyListeners();
  }

  // Method to toggle between light and dark themes
  void toggleTheme() {
    if (_themeData == AppTheme.lightTheme) {
      themeData = AppTheme.darkTheme; 
      themeIcon = Icon(Iconsax.moon);
    } else {
      themeData = AppTheme.lightTheme;
      themeIcon = Icon(Iconsax.sun_14);
    }
  }
}
