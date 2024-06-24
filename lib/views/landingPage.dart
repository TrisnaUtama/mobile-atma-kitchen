import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile_atma_kitchen/views/login.view.dart';

final String backendUrl = 'http://10.0.2.2:8000/api/v1/getAllProduk';

class Produk {
  final String namaProduk;
  final double harga;
  final String kategori;
  final int stok;
  final String gambar;

  Produk({
    required this.namaProduk,
    required this.harga,
    required this.kategori,
    required this.stok,
    required this.gambar,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      namaProduk: json['nama_produk'],
      harga: json['harga'].toDouble(),
      kategori: json['kategori'],
      stok: json['stok'] ?? 0,
      gambar: json['gambar'],
    );
  }
}

class ProdukFetcher {
  static Future<List<Produk>> fetchProduk() async {
    try {
      final response = await http.get(Uri.parse(backendUrl));

      if (response.statusCode == 200) {
        List<Produk> produkList = [];
        final parsed = jsonDecode(response.body);
        if (parsed['status']) {
          for (var produk in parsed['data']) {
            produkList.add(Produk.fromJson(produk));
          }
          return produkList;
        } else {
          throw Exception(parsed['message']);
        }
      } else {
        throw Exception('Failed to load produk: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}

class ProdukList extends StatefulWidget {
  @override
  _ProdukListState createState() => _ProdukListState();
}

class _ProdukListState extends State<ProdukList> {
  late Future<List<Produk>> futureProduk;

  @override
  void initState() {
    super.initState();
    futureProduk = ProdukFetcher.fetchProduk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produk List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.login_outlined),
            onPressed: () {
              print("Login button pressed");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enableInfiniteScroll: true,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: [
                Image.asset(
                  'assets/images/promo2.gif',
                  fit: BoxFit.fitWidth,
                ),
                Image.asset(
                  'assets/images/promo3.gif',
                  fit: BoxFit.fitWidth,
                ),
                Image.asset(
                  'assets/images/promo4.gif',
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 400, // Set the height of the container
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FutureBuilder<List<Produk>>(
                future: futureProduk,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 200,
                          height: 300,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 225, 228, 230),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Container(
                                width: 200, // set your desired width
                                height: 200, // set your desired height
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'http://10.0.2.2:8000/storage/produk/${snapshot.data![index].gambar}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                snapshot.data![index].namaProduk,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Rp ${snapshot.data![index].harga.toStringAsFixed(0)}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Kategori: ${snapshot.data![index].kategori}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Stok: ${snapshot.data![index].stok.toString()}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else {
                    return Center(
                      child: Text("Unknown error"),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            // Card for map
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lokasi Toko',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Alamat: Jl. Babarsari No. 123, Kampus 3 Atma Jaya Yogyakarta',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: Image.asset(
                        'assets/images/maps.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Card for store description
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deskripsi Toko',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: Image.asset(
                        'assets/images/gambar toko.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Toko ini menyediakan berbagai macam produk yang berkualitas dan premium sehingga hanya untuk kaum kaum yang bukan mendang mending.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProdukList(),
  ));
}
