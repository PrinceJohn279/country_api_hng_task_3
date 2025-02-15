import 'package:country_api_hng_task_3/utils/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
runApp(
ChangeNotifierProvider(
  create: (context) => ThemeProvider(),
  child: const App(),
),
);
}
