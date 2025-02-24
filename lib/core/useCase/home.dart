// ignore_for_file: unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter_application_1/core/models/model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController {
  var url = dotenv.env['baseUrl'];

  Future getCategories() async {
    Uri urlCategories = Uri.parse("http://172.10.10.7:3000/categories");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Login dataUser = loginFromJson(prefs.getString('login')!);
    String token = 'Bearer' + dataUser.token;

    var response = await http.get(urlCategories, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    }); 

    if (response.statusCode == 200) {
      List<Categories> data = categoriesFromJson(response.body);
      return data;
    } else {
      return null;
    }

  } 
}