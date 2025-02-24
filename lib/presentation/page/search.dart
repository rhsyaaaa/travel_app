// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> destinations = [
    {'name': 'Kuta Beach', 'category': 'Beach', 'price': '\$245.00', 'rating': '4.5', 'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 'img': 'assets/page3.jpg', 'isFavorite': false},
    {'name': 'Kuta Resort', 'category': 'Beach', 'price': '\$245.00', 'rating': '4.6', 'description': 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'img': 'assets/page3.jpg', 'isFavorite': false},
    {'name': 'Merapi Mountain', 'category': 'Mountain', 'price': '\$180.00', 'rating': '4.3', 'description': 'Excepteur sint occaecat cupidatat non proident.', 'img': 'assets/page3.jpg', 'isFavorite': false},
    {'name': 'Bromo Mountain', 'category': 'Mountain', 'price': '\$220.00', 'rating': '4.9', 'description': 'Sunt in culpa qui officia deserunt mollit anim id est laborum.', 'img': 'assets/page3.jpg', 'isFavorite': false},
  ];

  String selectedCategory = '';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredDestinations = destinations.where((destination) {
      return (selectedCategory.isEmpty || destination['category'] == selectedCategory) &&
          destination['name']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search destination',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    // Implement filter functionality here
                     showFilterBottomSheet(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                categoryButton('All', Icons.all_inclusive),
                SizedBox(width: 10),
                categoryButton('Beach', Icons.beach_access),
                SizedBox(width: 10),
                categoryButton('Mountain', Icons.terrain),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDestinations.length,
                itemBuilder: (context, index) {
                  var destination = filteredDestinations[index];
                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(destination['img']!, width: 100, height: 100, fit: BoxFit.cover),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      destination['name']!,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      destination['price']!,
                                      style: TextStyle(fontSize: 16, color: Colors.green),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.amber, size: 20),
                                        SizedBox(width: 5),
                                        Text(destination['rating']!, style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      destination['description']!,
                                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  destination['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                                  color: destination['isFavorite'] ? Colors.red : Colors.grey,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    destination['isFavorite'] = !destination['isFavorite'];
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryButton(String category, IconData icon) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (category == 'All') {
            selectedCategory = ''; 
          } else {
            selectedCategory = category;
          }
          searchQuery = ''; 
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedCategory == category ? Colors.green : Colors.white,
        foregroundColor: selectedCategory == category ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.green),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 5),
          Text(category),
        ],
      ),
    );
  }
}


void showFilterBottomSheet(BuildContext context) {
  double minPrice = 100;
  double maxPrice = 7000;
  int selectedStars = 0;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Filter", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text("Range Price"),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.black,
                    thumbColor: Colors.black,
                  ),
                  child: RangeSlider(
                    values: RangeValues(minPrice, maxPrice),
                    min: 100,
                    max: 7000,
                    onChanged: (RangeValues values) {
                      setState(() {
                        minPrice = values.start;
                        maxPrice = values.end;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16),
                Text("Star Review"),
                Column(
                  children: List.generate(5, (index) {
                    return ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (starIndex) {
                          return Icon(
                            Icons.star,
                            color: starIndex < index + 1 ? Colors.amber : Colors.grey,
                          );
                        }),
                      ),
                      trailing: Radio<int>(
                        value: index + 1,
                        groupValue: selectedStars,
                        onChanged: (int? value) {
                          setState(() {
                            selectedStars = value!;
                          });
                        },
                      ),
                    );
                  }),
                ),
                SizedBox(height: 16),
                Text("Included"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilterChip(label: Text("All"), onSelected: (bool selected) {}),
                    FilterChip(label: Text("Flight"), onSelected: (bool selected) {}),
                    FilterChip(label: Text("Hotel"), onSelected: (bool selected) {}),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          minPrice = 100;
                          maxPrice = 7000;
                          selectedStars = 0;
                        });
                      },
                      child: Text("Clear All", style: TextStyle(color: Colors.red)),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                      child: Text("Apply", style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}