import 'package:country_api_hng_task_3/utils/device_utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../utils/constants/image_strings.dart';
import '../utils/theme/theme_provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = DeviceUtils.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 0),
      child: AppBar(
        // Sets the title of the AppBar with a specific text style
        title: dark
            ? Image(
                image: AssetImage(ImageStrings.logo),
                width: 100,
                height: 100,
              )
            : Image(
                image: AssetImage(ImageStrings.logoDark),
                width: 100,
                height: 100,
              ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Icon(Iconsax.sun_14),
            alignment: Alignment.bottomRight,
            color: Colors.amber,
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}
