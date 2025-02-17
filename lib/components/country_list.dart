import 'dart:convert';

import 'package:country_api_hng_task_3/components/country_card.dart';
import 'package:country_api_hng_task_3/model/country.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../utils/device_utils/device_utils.dart';

// StatefulWidget to display a list of countries
class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

// Function to fetch the list of countries from the API
Future<List<Country>> fetchCountries() async {
  final response = await http.get(
    Uri.parse("https://restcountries.com/v3.1/all"),
  );

  if (response.statusCode == 200) {
    // Decode the JSON response
    List jsonResponse = json.decode(response.body);
    if (kDebugMode) {
      print(jsonResponse);
    }
    // Map the JSON data to a list of Country objects
    return jsonResponse.map((data) => Country.fromJson(data)).toList();
  } else {
    if (kDebugMode) {
      print("Failed to load: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
    // Throw an exception if the API call fails
    throw Exception("Failed to load");
  }
}

// State class for CountryList
class _CountryListState extends State<CountryList> {
  late Future<List<Country>> countries;
  List<Country> allCountries = [];
  List<Country> filteredCountries = [];
  String searchQuery = "";
  String selectedLanguage = "";
  List<String> availableLanguages = [];
  Map<String, List<Country>> groupedCountries = {};

  @override
  void initState() {
    super.initState();
    // Fetch the list of countries when the widget is initialized
    countries = fetchCountries();
    countries.then((value) {
      setState(() {
        // Sort the countries alphabetically by name
        allCountries = value..sort((a, b) => a.name.compareTo(b.name));
        filteredCountries = allCountries;
        // Extract available languages from the countries list
        availableLanguages = allCountries
            .expand((country) => country.languages.split(', '))
            .toSet()
            .toList()
          ..sort();
        // Group countries by their starting alphabet
        groupCountriesByAlphabet();
      });
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filterCountries();
    });
  }

  void filterCountries() {
    setState(() {
      filteredCountries = allCountries.where((country) {
        final matchesSearchQuery =
            country.name.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesLanguage = selectedLanguage.isEmpty ||
            country.languages
                .toLowerCase()
                .contains(selectedLanguage.toLowerCase());
        return matchesSearchQuery && matchesLanguage;
      }).toList();
      groupCountriesByAlphabet();
    });
  }

  void groupCountriesByAlphabet() {
    groupedCountries.clear();
    for (var country in filteredCountries) {
      String alphabet = country.name[0].toUpperCase();
      if (!groupedCountries.containsKey(alphabet)) {
        groupedCountries[alphabet] = [];
      }
      groupedCountries[alphabet]!.add(country);
    }
  }

  void showLanguageFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableLanguages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(availableLanguages[index]),
                  onTap: () {
                    setState(() {
                      selectedLanguage = availableLanguages[index];
                    });
                    Navigator.of(context).pop();
                    filterCountries();
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  selectedLanguage = "";
                });
                Navigator.of(context).pop();
                filterCountries();
              },
              child: Text('Clear Filter', style: TextStyle(fontSize: 17)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = DeviceUtils.isDarkMode(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          flexibleSpace: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 14, left: 14, bottom: 10,top: 0),
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 246, 244, 244),
                      border: Border.all(
                          color: const Color.fromARGB(255, 246, 244, 244)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon:
                            Icon(Iconsax.search_normal_1, color: Colors.grey),
                        hintText: 'Search countries...',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      onChanged: updateSearchQuery,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: dark ? Colors.white : Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 0.4,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Iconsax.global,
                                  color: dark ? Colors.white : Colors.black),
                              SizedBox(width: 4),
                              Center(
                                child: Text(
                                  selectedLanguage.isNotEmpty
                                      ? selectedLanguage.toUpperCase()
                                      : 'EN',
                                  style: TextStyle(
                                      color: dark ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 10),
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: dark ? Colors.white : Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 0.4,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: TextButton.icon(
                          label: Text('Filter',
                              style: TextStyle(
                                  color: dark ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          icon: Icon(Iconsax.filter,
                              color: dark ? Colors.white : Colors.black),
                          onPressed: showLanguageFilterDialog,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Country>>(
        future: countries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No countries found'));
          } else {
            return ListView.builder(
              itemCount: groupedCountries.keys.length,
              itemBuilder: (context, index) {
                String alphabet = groupedCountries.keys.elementAt(index);
                List<Country> countries = groupedCountries[alphabet]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        alphabet,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    ...countries
                        .map((country) => CountryCard(country: country))
                        .toList(),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
