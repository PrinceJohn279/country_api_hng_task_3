 import 'package:flutter/material.dart';

import '../../model/country.dart';

class TextWidget extends StatelessWidget {
  final Country country;
  final String title;
  final String subtitle;
  const TextWidget({
    super.key,
    required this.country,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "$title:",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 32 ,color: Colors.grey, fontWeight: FontWeight.w600)
              .apply(overflow: TextOverflow.ellipsis),
          maxLines: 1,
          softWrap: true,
        ),
      ],
    );
  }
}
