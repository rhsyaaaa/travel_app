// ignore_for_file: avoid_print, unused_local_variable, unused_import, empty_catches, unused_catch_clause, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter_application_1/core/models/model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Homecontroller {
  Future getCategory() async {
    var url = dotenv.env['baseUrl'];
    Uri urlCategories = Uri.parse("http://172.10.50.12:3000/categories");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Login user = loginFromJson(prefs.getString("login")!);
    print("User: ${user.token}");
    String token = "Bearer ${user.token}";
    print("Token: $token");

    try {
      print("masuk ke if ");
      final response = await http.get(urlCategories, headers: {
        "Content-Type": "application/json",
        "Authorization": token
      });
      print("Response Status Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        List<Categories> categories = categoriesFromJson(response.body);
        print(categories);
        return categories;
      }
    } on Exception catch (e) {
      throw Exception("Failed to load categories: $e");
    }
  }

  Future getWisata() async {
  Uri urlWisata = Uri.parse("http://172.10.50.12:3000/wisata");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Login user = loginFromJson(prefs.getString("login")!);
  print("User: ${user.token}");
  String token = "Bearer ${user.token}";
  print("Token: $token");
  try {
    print("masuk ke if ");
    final response = await http.get(urlWisata, headers: {
      "Content-Type": "application/json",
      "Authorization": token
    });
    print("Response Status Code: ${response.statusCode}");
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<DetailWisata> allWisata = jsonData.map((item) => DetailWisata.fromJson(item)).toList();
      List<DetailWisata> favorit = allWisata.where((x) => x.isFav == 1).toList();
      return [
        {"favorit": favorit, "popular": allWisata}
      ];
    }
  } on Exception catch (e) {
    throw Exception("Failed to load wisata: $e");
  }
}
}
