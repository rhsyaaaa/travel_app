// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/model.dart';
import 'package:flutter_application_1/core/routing/app_route.dart';
import 'package:flutter_application_1/core/useCase/homeController.dart';
import 'package:flutter_application_1/presentation/widget/popular.dart';
import 'package:flutter_application_1/presentation/widget/wisata.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Login? dataUser;
  List<Categories> dataCategory = [];
  List<DetailWisata> favorit = [];
  List<DetailWisata> popular = [];

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dataUser = loginFromJson(prefs.getString('login')!);
    });

    Homecontroller().getCategory().then(
          (value) => setState(() {
            if (value != null) {
              dataCategory = value;
            }
          }),
        );

    Homecontroller().getWisata().then((value) => setState(() {
          print(value);
          if (value != null) {
            favorit = value[0]["favorit"];
            popular = value[0]["popular"];
          }
        }));
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double tinggi = MediaQuery.of(context).size.height;
    double lebar = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/beach.png'),
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Text(
                          "HI ${dataUser?.data.name} ",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.notification_add, color: Colors.grey),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Where do you want to explore today?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Search destination",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Choose Category",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
                children: List.generate(
                    dataCategory.length,
                    (index) => categoryContainer(
                        dataCategory[index].name, dataCategory[index].image))),
            SizedBox(height: 20),
            Text(
              "Favorite Place",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                child: Wrap(
                    spacing: 10,
                    children: List.generate(
                      favorit.length,
                      (index) => Wisata(
                          favorit[index].gambarwisata,
                          favorit[index].namawisata,
                          favorit[index].lokasiwisata,
                          favorit[index].ratingWisata.toString(),
                          tinggi,
                          lebar,
                          context,
                          false),
                    )),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Package",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Explore",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                    popular.length,
                    (index) => InkWell(
                        onTap: () => context.goNamed(Routes.detail,
                            extra: popular[index]),
                        child: Popular(
                            popular[index].gambarwisata,
                            popular[index].namawisata,
                            popular[index].hargaWisata.toString(),
                            popular[index].ratingWisata,
                            popular[index].deskripsi.substring(0, 123),
                            lebar,
                            tinggi)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoryContainer(String title, String img) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.network(
            img,
          ),
          SizedBox(width: 5),
          Text(title),
        ],
      ),
    );
  }
}

