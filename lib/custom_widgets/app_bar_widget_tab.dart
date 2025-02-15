import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../utils/theme/theme_provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Explore", style: Theme.of(context).textTheme.labelLarge),
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
