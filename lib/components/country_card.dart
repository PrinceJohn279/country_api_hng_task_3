import 'package:country_api_hng_task_3/utils/device_utils/device_utils.dart';
import 'package:flutter/material.dart';

import '../model/country.dart';
import '../responsive_ui/pages/mobile_details.dart';
import '../responsive_ui/pages/tablet_details.dart';

// StatelessWidget to display a card with country information
class CountryCard extends StatelessWidget {
  final Country country;
  const CountryCard({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Navigate to the appropriate details page when the card is tapped
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceUtils.getScreenWidth(context) < 600
                ? MobileDetailsUi(country: country)
                : TabletDetailsUi(country: country),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    // Display the flag image of the country
                    height: 50,
                    width: 50,
                    country.flags,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      // Handle image loading errors
                      return Icon(
                        Icons.error,
                        color: Colors.red,
                      );
                    },
                  ),
                ),
              ),
            ),
            // Display the name of the country
            Text(
              country.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
