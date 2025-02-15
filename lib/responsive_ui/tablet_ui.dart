import 'package:country_api_hng_task_3/components/country_list.dart';
import 'package:country_api_hng_task_3/utils/device_utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../custom_widgets/app_bar_widget.dart';

class TabletUi extends StatelessWidget {
  const TabletUi({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DeviceUtils.isDarkMode(context);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
         statusBarColor: Colors.transparent,
         statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
         statusBarBrightness:  dark ? Brightness.dark : Brightness.light
      ));
      
    return Scaffold(
      appBar: MyAppBar(),
      body: const CountryList(),
    );
  }
}