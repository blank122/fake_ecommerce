// shimmer_loader.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final int itemCount; // Number of items to simulate
  final EdgeInsetsGeometry padding; // Padding for the shimmer effect

  const ShimmerLoader({
    super.key,
    this.itemCount = 6, // Default to 6 shimmer items
    this.padding = const EdgeInsets.all(16.0), // Default padding
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              leading: Container(
                width: 150.0,
                height: 150.0,
                color: Colors.grey,
              ),
              title: Container(
                width: double.infinity,
                height: 20.0,
                color: Colors.grey,
              ),
              subtitle: Container(
                width: 150,
                height: 20.0,
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
