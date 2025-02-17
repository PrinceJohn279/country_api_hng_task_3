import 'dart:convert';

import 'package:country_api_hng_task_3/components/country_card.dart';
import 'package:country_api_hng_task_3/model/country.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

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
      print(jsonResponse);    }
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
  List<Country> filteredCountries = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    // Fetch the list of countries when the widget is initialized
    countries = fetchCountries();
    countries.then((value) {
      setState(() {
        filteredCountries = value;
      });
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredCountries = filteredCountries
          .where((country) =>
              country.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 246, 244, 244),
            border: Border.all(color: const Color.fromARGB(255, 246, 244, 244)),
            borderRadius: BorderRadius.circular(3),
          ),
          child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Iconsax.search_normal_1, color: Colors.grey,),
              hintText: 'Search countries...',
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
            onChanged: updateSearchQuery,
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
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                return CountryCard(country: filteredCountries[index]);
              },
            );
          }
        },
      ),
    );
  }
}
