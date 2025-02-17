import 'package:country_api_hng_task_3/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../utils/device_utils/device_utils.dart';
import '../utils/theme/theme_provider.dart';

// A custom AppBar widget that implements PreferredSizeWidget
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  // Builds the AppBar widget
  @override
  Widget build(BuildContext context) {
    final dark = DeviceUtils.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.only(right: 14, left: 14, top:0, bottom: 0),
      child: AppBar(
        // Sets the title of the AppBar with a specific text style
        title: dark ? Image(
          image: AssetImage(ImageStrings.logoDark),
          width: 100,
        ): Image(
          image: AssetImage(ImageStrings.logo),
          width: 100,
        ),
        
        // Sets the background color of the AppBar
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        // Removes the shadow under the AppBar when scrolled
        scrolledUnderElevation: 0,
        // Adds actions to the AppBar
        actions: [
          IconButton(
            // Toggles the theme when the button is pressed
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            // Sets the icon of the button
            icon: Icon(Iconsax.sun_14),
            // Aligns the icon to the bottom right
            alignment: Alignment.bottomRight,
            // Sets the color of the icon
            color: Colors.amber,
          )
        ],
      ),
    );
  }

  // Sets the preferred size of the AppBar
  @override
  Size get preferredSize => Size.fromHeight(40);
}
