import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:mobile_atma_kitchen/models/Produk.dart';

class ProdukCard extends StatelessWidget {
  final Produk product;
  final Size size;

  const ProdukCard({
    super.key,
    required this.product,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    print(dataUser);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: size.height / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl:
                          'http://10.0.2.2:8000/storage/produk/${product.gambar}',
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) {
                        print('Error loading image: $error');
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      product.stok == 0 || product.stok == null
                          ? WidgetSpan(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors
                                      .red, // Background color for Sold Out
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Sold Out',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : TextSpan(
                              text: product.stok.toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
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
                      product.limit == null ||
                              product.limit!.isEmpty ||
                              product.limit!.first.limit == 0
                          ? WidgetSpan(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors
                                      .red, // Background color for Sold Out
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Sold Out',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : TextSpan(
                              text: product.limit!.first.limit.toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
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
                  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ')
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
  }
}
