import 'package:flutter/material.dart';

import '../../model/country.dart';

class TextWidget extends StatelessWidget {
  final Country country;
  final String title;
  final String subtitle;
  const TextWidget({
    super.key,
    /// The country parameter is required and represents the country information 
    /// that will be displayed or used within this widget.
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
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          width: 9,
        ),
        Text(
          subtitle,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)
              .apply(overflow: TextOverflow.ellipsis),
          maxLines: 1,
          softWrap: true,
        ),
      ],
    );
  }
}
