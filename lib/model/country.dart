class Country {
  final String name;
  final String flags;
  final String capital;
  final String coatOfArms;
  final String currencies;
  final String region;
  final String languages;
  final String area;
  final String population;
  final String car;
  final String timezones;
  final String continents;
  final String startOfWeek;


  Country( {
    required this.currencies, 
    required this.region, 
    required this.languages, 
    required this.area, 
    required this.population, 
    required this.car, 
    required this.timezones, 
    required this.continents, 
    required this.startOfWeek,
    required this.name,
    required this.flags,
    required this.capital,
    required this.coatOfArms,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json["name"]["common"] ?? "Unknown",
      capital: (json['capital'] != null && json['capital'].isNotEmpty)
          ? json['capital'][0]
          : 'Unknown',
      coatOfArms:
          json["coatOfArms"] != null && json["coatOfArms"]["png"] != null
              ? json["coatOfArms"]["png"]
              : "Unknown",
      flags: json["flags"]["png"] ?? "Unknown",
      currencies: json["currencies"] != null ? json["currencies"].toString() : "Unknown",
      region: json["region"] ?? "Unknown",
      languages: json["languages"] != null ? json["languages"].toString() : "Unknown",
      area: json["area"] != null ? json["area"].toString() : "Unknown",
      population: json["population"] != null ? json["population"].toString() : "Unknown",
      car: json["car"] != null ? json["car"].toString() : "Unknown",
      timezones: json["timezones"] != null ? json["timezones"].toString() : "Unknown",
      continents: json["continents"] != null ? json["continents"].toString() : "Unknown",
      startOfWeek: json["startOfWeek"] ?? "Unknown",
    );
  }
}
