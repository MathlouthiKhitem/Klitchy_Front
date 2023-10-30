import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'ProductDetails.dart';
import 'Classe/resto.dart';
import 'QRCodeScreen.dart';

class ListResturant extends StatefulWidget {
  @override
  _ListResturantState createState() => _ListResturantState();
}

class _ListResturantState extends State<ListResturant> {
  List<Resto> restos = [];

  // Define a variable to hold the fetched restos
  List<Resto> fetchedRestos = [];

  TextEditingController searchController = TextEditingController();
  Color _textColor = Colors.black;
  String selectedType = ''; // Add this variable to store the selected type

  List<String> yourImageList = [
    "assets/images/pngwing 2.png",
    "assets/images/pngwing 5.png",
    "assets/images/pngwing 2.png",
    "assets/images/pngwing 2.png",
    "assets/images/pngwing 5.png",
    // Add more image paths as needed
  ];

  String getImageText(int index) {
    // Replace this with your logic to get the text associated with the image at the given index
    // For example, you can have a list of text corresponding to each image path and return the text at the same index.
    List<String> imageTexts = [
      "Pizza ",
      "Italian ",
      "Tunisian",
      "Suchi",
      "Text 5",
      // Add more text as needed
    ];
    if (index < imageTexts.length) {
      return imageTexts[index];
    }
    return ""; // Return an empty string if the index is out of bounds
  }

// Initial text color

  @override
  void initState() {
    super.initState();
    // fetchRestos();
    fetchRestos().then((result) {
      setState(() {
        fetchedRestos = result;
      });
    });
  }

  Future<List<Resto>> fetchRestos() async {
   final String baseUrls = "http://192.168.1.18:3000/api/restos";
   // final String baseUrls = "http://10.0.2.2:3000/api/restos";


    try {
      final response = await http.get(Uri.parse(baseUrls));
      print(response);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print(data);

        final List<Resto> restos = data.map((item) => Resto.fromJson(item))
            .toList();
        print(restos);
        return restos;
      } else {
        print('Failed to load data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[


          SizedBox(height: 70),

          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Where',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF006C81),
                      ),
                    ),
                    TextSpan(
                      text: ' do you want to ',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF717579),
                      ),
                    ),
                    TextSpan(
                      text: 'eat?',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF006C81),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ScanScreen()),
                      );
                    },
                    icon: Icon(
                      Icons.qr_code_scanner_sharp,
                      size: 40,
                      color: Color(0xFF006C81), // Couleur de l'icône
                    ),
                  ),
                ),

              ),
            ],
          ),

          SizedBox(height: 16.0), // Add some spacing
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            margin: EdgeInsets.all(16.0),
            child: Focus(
              onFocusChange: (hasFocus) {
                setState(() {
                  _textColor = hasFocus ? Color(0xFF006C81) : Colors.black;
                });
              },
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search Restaurants',
                  suffixIcon: Icon(Icons.search, color: _textColor),
                  // Change the icon color based on focus
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  labelStyle: TextStyle(
                      color: _textColor), // Change the label text color based on focus
                ),
                onChanged: (value) {
                  // Handle search text change here
                },
              ),
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(yourImageList.length, (index) {
                final imagePath = yourImageList[index];
                final imageText = getImageText(index);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedType == imageText) {
                        // If the same type is tapped again, clear the filter
                        selectedType = '';
                      } else {
                        selectedType = imageText; // Update selectedType on card tap
                      }
                    });
                  },
                  child: Container(
                    width: 100.0,
                    height: 116.0,
                    child: Stack(
                      children: [
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: selectedType == imageText
                              ? Color(0xFFFF9242) // Highlight selected type
                              : Color(0xFF2EA6BD),
                          margin: EdgeInsets.fromLTRB(19, 31, 10, 30),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          left: 4,
                          top: -10,
                          width: 100.0,
                          height: 100.0,
                          child: Image.asset(imagePath),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(30, 65, 0, 0),
                          child: Text(imageText),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          Expanded(
            child: Builder(
              builder: (context) {
                // Create a local context using Builder
                // This allows us to use Scaffold.of(context) to show a SnackBar

                // Filter the list of restaurants based on the selectedType
                final filteredRestos = fetchedRestos
                    .where((resto) =>
                selectedType.isEmpty || resto.typeResto == selectedType)
                    .toList();

                return ListView.builder(
                  itemCount: filteredRestos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Resto resto = filteredRestos[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(19, 12, 19, 13),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: Stack(
                            children: [
                              Container(
                                width: 400.0,
                                height: 200.0,
                                child: ColorFiltered(
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white24,
                                    BlendMode.saturation,
                                  ),
                                  child: Image.network(
                                    resto.imgurl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 130,
                                left: 10,
                                child: Text(
                                  resto.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 170,
                                left: 10,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Color(0xFF006C81),
                                      size: 22.0,
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      resto.address,
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF006C81),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 160,
                                right: 20,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_circle_right_outlined,
                                      color: Color(0xFFFF9242),
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 4.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
