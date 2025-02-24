// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/model.dart';
import 'package:flutter_application_1/core/useCase/home.dart';
import 'package:flutter_application_1/presentation/page/widget/popular.dart';
import 'package:flutter_application_1/presentation/page/widget/wisata.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Login? dataUser;
  List<Categories> dataCategory = [];

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dataUser = loginFromJson(prefs.getString('login')!);
    });

    HomeController().getCategories().then((value) => setState(() {
          if (value != null) {
            dataCategory = value;
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
                          "Hi ${dataUser?.data.name} ",
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
                  dataCategory[index].name, dataCategory[index].image),
            )),
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
                  children: [
                    Wisata("assets/page1.jpg", "Tempat Wisata",
                        "Jonggol, Indonesia", "4.8", tinggi, lebar, context),
                    Wisata("assets/page1.jpg", "Tempat Wisata",
                        "Jonggol, Indonesia", "4.8", tinggi, lebar, context),
                    Wisata("assets/page1.jpg", "Tempat Wisata",
                        "Jonggol, Indonesia", "4.8", tinggi, lebar, context),
                    Wisata("assets/page1.jpg", "Tempat Wisata",
                        "Jonggol, Indonesia", "4.8", tinggi, lebar, context),
                    Wisata("assets/page1.jpg", "Tempat Wisata",
                        "Jonggol, Indonesia", "4.8", tinggi, lebar, context),
                  ],
                ),
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
                  children: [
                    Popular(
                        "assets/page1.jpg",
                        "Tempat Wisata",
                        "500000",
                        4.8,
                        "Lorem ipsum dolor sit amet consectetur adipisicing elit...",
                        lebar,
                        tinggi),
                    Popular(
                        "assets/page2.jpg",
                        "Tempat Wisata",
                        "300000",
                        4.8,
                        "Lorem ipsum dolor sit amet consectetur adipisicing elit...",
                        lebar,
                        tinggi),
                    Popular(
                        "assets/page3.jpg",
                        "Tempat Wisata",
                        "800000",
                        4.8,
                        "Lorem ipsum dolor sit amet consectetur adipisicing elit...",
                        lebar,
                        tinggi),
                  ],
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
