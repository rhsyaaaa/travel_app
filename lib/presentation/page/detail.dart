// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';

class detailScreen extends StatefulWidget {
  const detailScreen({super.key});

  @override
  State<detailScreen> createState() => _detailScreenState();
}

class _detailScreenState extends State<detailScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Detail(),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Kuta Beach"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline))
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/page3.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: 16,
                      left: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kuta Beach",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.white),
                              SizedBox(width: 4),
                              Text(
                                "Bali, Indonesia",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            "100 + people have explored",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow, size: 18),
                              Icon(Icons.star, color: Colors.yellow, size: 18),
                              Icon(Icons.star, color: Colors.yellow, size: 18),
                              Icon(Icons.star, color: Colors.yellow, size: 18),
                              Icon(Icons.star_half,
                                  color: Colors.yellow, size: 18),
                              SizedBox(width: 4),
                              Text(
                                "4.5",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              ),
              SizedBox(height: 20),
              Text("What's Included?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Chip(
                    avatar: Icon(
                      Icons.flight_takeoff,
                      size: 20,
                      color: Colors.yellow,
                    ),
                    label: Text("Flight"),
                  ),
                  SizedBox(width: 8),
                  Chip(
                    avatar: Icon(Icons.hotel, size: 20, color: Colors.yellow),
                    label: Text("Hotel"),
                  ),
                  SizedBox(width: 8),
                  Chip(
                    avatar: Icon(Icons.directions_car,
                        size: 20, color: Colors.yellow),
                    label: Text("Transport"),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text("About Trip",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                  "Pantai Kuta punya vibes santai dengan pasir putih dan ombak yang pas untuk berselancar. Suasana ramai dengan wisatawan, pedagang, dan musik pantai. Sunset di sini indah, sering jadi spot foto favorit. Malamnya, area sekitar hidup dengan kafe dan hiburan. Pantai Kuta punya vibes santai dengan pasir putih dan ombak yang pas untuk berselancar. Suasana ramai dengan wisatawan, pedagang, dan musik pantai. Sunset di sini indah, sering jadi spot foto favorit. Malamnya, area sekitar hidup dengan kafe dan hiburan. Pantai Kuta punya vibes santai dengan pasir putih dan ombak yang pas untuk berselancar. Suasana ramai dengan wisatawan, pedagang, dan musik pantai. Sunset di sini indah, sering jadi spot foto favorit. Malamnya, area sekitar hidup dengan kafe dan hiburan. Pantai Kuta punya vibes santai dengan pasir putih dan ombak yang pas untuk berselancar. Suasana ramai dengan wisatawan, pedagang, dan musik pantai. Sunset di sini indah, sering jadi spot foto favorit. Malamnya, area sekitar hidup dengan kafe dan hiburan."),
              SizedBox(height: 24),
              Text("Gallery Photo",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'assets/page3.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'assets/page3.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.darken),
                            child: Image.asset(
                              'assets/page3.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                            child: Center(
                          child: Text(
                            "20+",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text("Location",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                    image: AssetImage('assets/map_kuta.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text("Reviews (99)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListTile(
                leading: CircleAvatar(),
                title: Text("Yelena Belova"),
                subtitle: Text(
                    "Pretty nice place aojdsoajsd asodjaoksd joaso a osjdoasjd ojas"),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: CircleAvatar(),
                title: Text("Yelena Belova"),
                subtitle: Text(
                    "Pretty nice place aksdajsdklaj lkjskl jdklaj dksla kads"),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: CircleAvatar(),
                title: Text("Yelena Belova"),
                subtitle: Text(
                    "Pretty nice place askldj alksdjka lsdlkasd lka sdasd"),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$745.00",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    minimumSize: Size(400, 60),
                  ),
                  child: Text("Booking Now",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ));
  }
}