import 'package:fake_e_commerce/controller/home_controller.dart';
import 'package:fake_e_commerce/model/product.dart';
import 'package:fake_e_commerce/widgets/shimmer.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
    super.initState();
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
            ) // Use the reusable ShimmerLoader widget
          : dataList.isEmpty
              ? const Center(
                  child: Text('No Products found.'),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      final Product productList = dataList[index];

                      //create a stateless widget to show the data (for better perfomance)
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Image.network(
                                productList.image,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                              Text(
                                productList.title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                productList.description,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
