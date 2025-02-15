import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_api_hng_task_3/utils/device_utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../custom_widgets/text_widgets/row_text.dart';
import '../../model/country.dart';

// StatefulWidget for displaying country details on a tablet
class TabletDetailsUi extends StatefulWidget {
  final Country country;
  const TabletDetailsUi({super.key, required this.country});

  @override
  _TabletDetailsUiState createState() => _TabletDetailsUiState();
}

// State class for TabletDetailsUi
class _TabletDetailsUiState extends State<TabletDetailsUi> {
  late Future<void> refreshFuture;
  late Country country;

  @override
  void initState() {
    super.initState();
    // Initialize the country with the provided country data
    country = widget.country;
    // Fetch the latest country data
    refreshFuture = refreshData();
  }

  // Method to refresh country data by fetching from the API
  Future<void> refreshData() async {
    final response = await http.get(
      Uri.parse("https://restcountries.com/v3.1/name/${country.name}"),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        // Update the country data with the fetched data
        country = Country.fromJson(jsonResponse[0]);
      });
    } else {
      // Throw an exception if the data fetch fails
      throw Exception("Failed to load country data");
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Flag URL: ${widget.country.flags}');
    print('Coat of Arms URL: ${widget.country.coatOfArms}');

    final formattedPopulation = NumberFormat.decimalPattern()
        .format(int.parse(widget.country.population));
// Function to remove the first and last characters from a string
    String removeFirstAndLastChar(String str) {
      if (str.length <= 2) {
        return ''; // Return an empty string if the input string is too short
      }
      return str.substring(1, str.length - 1);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          widget.country.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Carousal
              Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 5),
                child: CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                  ),
                  items: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          width: DeviceUtils.getScreenWidth(context) - 25,
                          widget.country.flags,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading flag image: $error');
                            return Icon(
                              Icons.error,
                              color: Colors.orangeAccent,
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.country.coatOfArms,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading coat of arms image:: $error');
                            return Icon(
                              Icons.error,
                              color: Colors.orangeAccent,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Details
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    TextWidget(
                      country: widget.country,
                      title: "Population",
                      subtitle: formattedPopulation,
                    ),
                    TextWidget(
                      country: widget.country,
                      title: "Region",
                      subtitle: widget.country.region,
                    ),
                    TextWidget(
                      country: widget.country,
                      title: "Capital",
                      subtitle: widget.country.capital,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextWidget(
                      country: widget.country,
                      title: "Official language",
                      subtitle:
                          removeFirstAndLastChar(widget.country.languages),
                    ),
                    TextWidget(
                      country: widget.country,
                      title: "Area",
                      subtitle: widget.country.area.toString(),
                    ),
                    TextWidget(
                      country: widget.country,
                      title: "Start of week",
                      subtitle: widget.country.startOfWeek,
                    ),
                    TextWidget(
                      country: widget.country,
                      title: "Time zone",
                      subtitle:
                          removeFirstAndLastChar(widget.country.timezones),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextWidget(
                      country: widget.country,
                      title: "Currency",
                      subtitle:
                          removeFirstAndLastChar(widget.country.currencies),
                    ),
                    TextWidget(
                      country: widget.country,
                      title: "Continent",
                      subtitle:
                          removeFirstAndLastChar(widget.country.continents),
                    ),
                    TextWidget(
                      country: widget.country,
                      title: "Driving Side",
                      subtitle: widget.country.car,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}