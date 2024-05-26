import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import 'package:mobile_atma_kitchen/controllers/ProdukDisplay/produk.display.controller.dart';
import 'package:mobile_atma_kitchen/models/Hampers.dart';
import 'package:mobile_atma_kitchen/models/Produk.dart';
import 'package:mobile_atma_kitchen/views/Customer/Produk/components/hampersCard.dart';
import 'package:mobile_atma_kitchen/views/Customer/Produk/components/produkCard.dart';

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
                  FutureBuilder<List<dynamic>>(
                    future: Produk2Display().ProdukDisplay(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final data = snapshot.data ?? [];
                        final produkList = data
                            .where((item) => item is Produk)
                            .toList()
                            .cast<Produk>();

                        final hampersList = data
                            .where((item) => item is Hampers)
                            .toList()
                            .cast<Hampers>();

                        List<dynamic> mergedData = [
                          ...produkList,
                          ...hampersList
                        ];

                        final filteredData = mergedData.where((item) {
                          final namaProduk = item is Produk
                              ? item.nama_produk.toLowerCase()
                              : (item is Hampers
                                  ? item.nama_hampers.toLowerCase()
                                  : '');
                          final kategori = item.kategori;
                          final matchesQuery =
                              namaProduk.contains(searchQuery.toLowerCase());
                          final matchesFilter =
                              filters.isEmpty || filters.contains(kategori);
                          return matchesQuery && matchesFilter;
                        }).toList();
                        final length = filteredData.length;
                        return Column(
                          children: [
                            GridView.builder(
                              padding: const EdgeInsets.all(10.0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 0.50,
                              ),
                              itemCount: length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = filteredData[index];
                                if (item is Produk) {
                                  return ProdukCard(
                                    product: item,
                                    size: size,
                                  );
                                } else if (item is Hampers) {
                                  return HampersCard(
                                    hampers: item,
                                    size: size,
                                  );
                                }
                              },
                            ),
                          ],
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
