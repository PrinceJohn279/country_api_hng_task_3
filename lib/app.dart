    
import 'package:country_api_hng_task_3/responsive_ui/mobile_ui.dart';
import 'package:country_api_hng_task_3/utils/device_utils/device_utils.dart';
import 'package:country_api_hng_task_3/utils/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'responsive_ui/tablet_ui.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: DeviceUtils.getScreenWidth(context) < 600 ? MobileUi() : TabletUi(),
    );
  }
}
