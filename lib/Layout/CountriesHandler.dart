import 'dart:convert';
import 'package:flutter/services.dart';

class CountriesHandler {
  Future<Map> getCountry(String name) async {
    Map data = jsonDecode(await rootBundle.loadString('data/data.json'));
    return data["countries"][name];
  }

  Future<Map> getCountries() async {
    Map data = jsonDecode(await rootBundle.loadString('data/data.json'));
    return data["countries"];
  }
}
