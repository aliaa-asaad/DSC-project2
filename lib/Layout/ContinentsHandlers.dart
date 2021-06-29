import 'dart:convert';
import 'package:flutter/services.dart';

class ContinentsHandler {
  Future<Map> getContinent(String name) async {
    Map data = jsonDecode(await rootBundle.loadString('data/data.json'));
    return data["continents"][name];
  }

  Future<Map> getContinents() async {
    Map data = jsonDecode(await rootBundle.loadString('data/data.json'));
    return data["continents"];
  }
}
