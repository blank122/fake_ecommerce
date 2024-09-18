import 'package:fake_e_commerce/controller/home_controller.dart';
import 'package:fake_e_commerce/home/product_details.dart';
import 'package:fake_e_commerce/model/product.dart';
import 'package:fake_e_commerce/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = HomeController();
  List<Product> dataList = [];
  bool isFetching = true;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    final List<Product>? listOfData = await homeController.getProducts();
    setState(() {
      dataList = listOfData ?? [];
      isFetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pakyo'),
      ),
      body: isFetching
          ? const ShimmerLoader(
              itemCount: 4,
            )
          : dataList.isEmpty
              ? const Center(
                  child: Text('No Products found.'),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 0.75,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final Product productList = dataList[index];
                            developer.log(
                                'product list image: ${productList.image[0]}');
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Navigate to Product Detail Screen
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetails(
                                              data: productList,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Image.network(
                                        productList.image.isNotEmpty
                                            ? productList.image[0]
                                            : 'https://via.placeholder.com/100', // Display first image, fallback to placeholder if empty
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 100,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      productList.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      productList.description,
                                      style: const TextStyle(fontSize: 14),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: dataList.length,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
