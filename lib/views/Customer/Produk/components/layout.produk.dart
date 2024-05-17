import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import 'package:mobile_atma_kitchen/controllers/ProdukDisplay/produk.display.controller.dart';
import 'package:mobile_atma_kitchen/models/Produk.dart';

class ProdukList extends StatefulWidget {
  const ProdukList({Key? key}) : super(key: key);

  @override
  _ProdukListState createState() => _ProdukListState();
}

class _ProdukListState extends State<ProdukList> {
  final filterData = ["Roti", "Cake", "Minuman", "Hampers", "Titipan"];
  final List<String> filters = [];
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
            child: CupertinoSearchTextField(
              placeholder: 'Search',
              suffixIcon: Icon(Icons.cancel_outlined),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 5.0,
                  runSpacing: 3.0,
                  children: filterData.map((filter) {
                    final isSelected = filters.contains(filter);
                    return FilterChip(
                      selectedColor: Colors.black,
                      label: Text(
                        filter,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      avatar: isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20.0,
                            )
                          : null,
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            filters.add(filter);
                          } else {
                            filters.remove(filter);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        image: DecorationImage(
                          image: AssetImage('assets/images/discount_logo.gif'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  FutureBuilder<List<Produk>>(
                    future: Produk2Display().ProdukDisplay(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final products = snapshot.data ?? [];
                        final filteredProducts = products.where((product) {
                          final matchesQuery = product.nama_produk
                              .toLowerCase()
                              .contains(searchQuery);
                          final matchesFilter = filters.isEmpty ||
                              filters.contains(product.kategori);
                          return matchesQuery && matchesFilter;
                        }).toList();
                        return GridView.builder(
                          padding: const EdgeInsets.all(10.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.50,
                          ),
                          itemCount: filteredProducts.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: size.height / 4,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'http://10.0.2.2:8000/storage/produk/${product.gambar}',
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) {
                                                print(
                                                    'Error loading image: $error');
                                                return Icon(Icons.error);
                                              },
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          product.kategori,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          product.nama_produk,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Ready Stock : ",
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              product.stok == null
                                                  ? WidgetSpan(
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 4,
                                                                vertical: 2),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .red, // Background color for Sold Out
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: Text(
                                                          'Sold Out',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 13,
                                                            color: Colors
                                                                .white, // Text color for Sold Out
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : TextSpan(
                                                      text: product.stok
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Pre-Order : ",
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              product.limit!.isEmpty
                                                  ? WidgetSpan(
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 4,
                                                                vertical: 2),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .red, // Background color for Sold Out
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: Text(
                                                          'Sold Out',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 13,
                                                            color: Colors
                                                                .white, // Text color for Sold Out
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : TextSpan(
                                                      text: product.limit!.first.limit
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          NumberFormat.currency(
                                                  locale: 'id_ID',
                                                  symbol: 'Rp. ')
                                              .format(product.harga),
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
