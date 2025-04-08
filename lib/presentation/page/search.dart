// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/model.dart';
import 'package:flutter_application_1/core/routing/app_route.dart';
import 'package:flutter_application_1/core/useCase/homeController.dart';
import 'package:flutter_application_1/presentation/widget/judul.dart';
import 'package:flutter_application_1/presentation/widget/popular.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  final int categoryID;
  final String? searchQuery;

  const SearchScreen({
    required this.categoryID,
    this.searchQuery,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<DetailWisata> filtered = [];
  int selectedRating = 0;
  RangeValues selectedPriceRange = RangeValues(100, 1000000);

  @override
  void initState() {
    super.initState();
    filteredData();
  }

  // Filter data berdasarkan kategori dan query pencarian
  void filteredData({String? searchQuery}) async {
    final controller = Homecontroller();
    var rawData = await controller.getWisata();

    List<DetailWisata> data;
    if (rawData is List<Map<String, List<DetailWisata>>>) {
      data = rawData.expand((map) => map.values.expand((list) => list)).toList();
    } else if (rawData is List<DetailWisata>) {
      data = rawData;
    } else {
      print("Error: Unexpected data format");
      return;
    }

    List<DetailWisata> isi;

    String query = searchQuery ?? widget.searchQuery ?? "";

    if (query.isNotEmpty) {
      isi = data
          .where((item) =>
              item.namawisata.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else if (widget.categoryID != 0) {
      isi = data.where((item) => item.idCategory == widget.categoryID).toList();
    } else {
      isi = data;
    }

    popupFiltered(isi);
  }

  // Filter data berdasarkan rating dan harga
  void popupFiltered(List<DetailWisata> allData) {
    List<DetailWisata> rslt = List.from(allData);

    // Filter rating
    if (selectedRating > 0 && selectedRating <= 5) {
      rslt = rslt
          .where((item) => item.ratingWisata.toInt() == selectedRating)
          .toList();
      print("Filtered by rating: $selectedRating");
    } else {
      print("No rating filter applied.");
    }

    // Filter harga
    if (selectedPriceRange.start > 100 || selectedPriceRange.end < 1000000) {
      rslt = rslt
          .where((item) =>
              item.hargaWisata >= selectedPriceRange.start &&
              item.hargaWisata <= selectedPriceRange.end)
          .toList();
      print(
          "Filtered by price range: ${selectedPriceRange.start} - ${selectedPriceRange.end}");
    } else {
      print("No price range filter applied.");
    }

    setState(() {
      filtered = rslt;
    });

    if (filtered.isEmpty) {
      print("Hasil tidak ditemukan.");
    }
  }

  // Menampilkan modal filter
  void showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        int tempRating = selectedRating;
        RangeValues tempPriceRange = selectedPriceRange;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Range Price"),
                  RangeSlider(
                    values: tempPriceRange,
                    min: 100,
                    max: 1000000,
                    divisions: 50,
                    labels: RangeLabels(
                      tempPriceRange.start.toStringAsFixed(0),
                      tempPriceRange.end.toStringAsFixed(0),
                    ),
                    onChanged: (values) {
                      setModalState(() => tempPriceRange = values);
                    },
                  ),
                  SizedBox(height: 16),
                  Text("Star Review"),
                  Row(
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          color:
                              index < tempRating ? Colors.amber : Colors.grey,
                        ),
                        onPressed: () {
                          setModalState(() => tempRating = index + 1);
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedRating = 0;
                            selectedPriceRange = RangeValues(100, 1000000);
                            filteredData(); // Reset filter
                          });
                          Navigator.pop(context);
                        },
                        child: Text("Clear All"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            selectedRating = tempRating;
                            selectedPriceRange = tempPriceRange;
                          });
                          popupFiltered(filtered);
                          Navigator.pop(context);
                        },
                        child: Text("Apply"),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.goNamed(Routes.home);
          },
        ),
        title: Text('Search'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list_alt),
            onPressed: () {
              showFilterSheet();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                margin: EdgeInsets.only(bottom: tinggi * 0.03),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search destination",
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    hintStyle: GoogleFonts.poppins(fontSize: 20),
                  ),
                  onChanged: (value) => filteredData(searchQuery: value),
                ),
              ),
              Judul("Data dari kategori yang dipilih", "", tinggi),
              Container(
                margin: EdgeInsets.only(bottom: tinggi * 0.03),
                child: filtered.isEmpty
                    ? Center(
                        child: Text(
                          "Data not found",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Wrap(
                        runSpacing: 30,
                        children: List.generate(
                          filtered.length,
                          (index) => Popular(
                            filtered[index].gambarwisata,
                            filtered[index].namawisata,
                            filtered[index].hargaWisata.toString(),
                            filtered[index].ratingWisata,
                            filtered[index].deskripsi,
                            lebar,
                            tinggi,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}