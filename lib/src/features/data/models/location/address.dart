class Address {
  String shop;
  String houseNumber;
  String road;
  String neighbourhood;
  String suburb;
  String county;
  String city;
  String state;
  String postcode;
  String country;
  String countryCode;

  Address({
    required this.shop,
    required this.houseNumber,
    required this.road,
    required this.neighbourhood,
    required this.suburb,
    required this.county,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        shop: json["shop"] ?? '',
        houseNumber: json["house_number"] ?? '',
        road: json["road"] ?? '',
        neighbourhood: json["neighbourhood"] ?? '',
        suburb: json["suburb"] ?? '',
        county: json["county"] ?? '',
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        postcode: json["postcode"] ?? '',
        country: json["country"] ?? '',
        countryCode: json["country_code"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "shop": shop,
        "house_number": houseNumber,
        "road": road,
        "neighbourhood": neighbourhood,
        "suburb": suburb,
        "county": county,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "country_code": countryCode,
      };
}
