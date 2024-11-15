import 'package:flutter/material.dart';
import 'base_page.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;

  HomePage(this.controller);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> allProducts = []; // List produk asli
  List<Map<String, dynamic>> filteredProducts = []; // List hasil pencarian

  @override
  void initState() {
    super.initState();
    allProducts = [
      {
        'name': 'Beras Premium',
        'price': 50000,
        'imageUrl': 'https://c.alfagift.id/product/1/1_A28090002703_20210803114025164_base.jpg',
      },
      {
        'name': 'Gula Pasir',
        'price': 15000,
        'imageUrl': 'https://down-id.img.susercontent.com/file/b1dd6c7f52722fa539154357e2d19018',
      },
      {
        'name': 'Minyak Goreng',
        'price': 25000,
        'imageUrl': 'https://down-id.img.susercontent.com/file/id-11134207-7r992-lszs8doi94gp72',
      },
      {
        'name': 'Garam Dapur',
        'price': 10000,
        'imageUrl': 'https://c.alfagift.id/product/1/1_A6859720001022_20181107151610095_base.jpg',
      },
      {
        'name': 'Meises',
        'price': 25000,
        'imageUrl': 'https://down-id.img.susercontent.com/file/def909e1b5e3e9a2cfc2665af0cf2637',
      },
    ];
    filteredProducts = allProducts;
  }

  void _filterProducts(String query) {
    setState(() {
      // untuk filter produk sesuai dengan query di search bar
      filteredProducts = allProducts
          .where((product) =>
              product['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      bodyContent: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari kebutuhan sehari-hari...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: _filterProducts, // untuk manggil fungsi filter saat teks berubah
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(filteredProducts.length, (index) {
                  final product = filteredProducts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Container(
                      width: 150, 
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            product['imageUrl'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8),
                          Text(
                            product['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Rp${product['price']}',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
      selectedIndex: 2,
      controller: widget.controller,
    );
  }
}
