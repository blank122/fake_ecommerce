import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:fake_e_commerce/model/product.dart';
import 'package:http/http.dart' as http;

class HomeController {
  Future<List<Product>?> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/products'),
      );

      if (response.statusCode == 200) {
        // Log the raw response
        // developer.log('Response Data: ${response.body}');

        // Decode the response
        final List<dynamic> responseData = json.decode(response.body);

        // Parse the list of products
        List<Product> products = responseData.map<Product>((item) {
          return Product.fromMap(item);
        }).toList();
        developer.log('data converted to map: $products');
        return products;
      } else {
        developer.log(
            'Response Error: ${response.statusCode} ${response.reasonPhrase}');
        return null;
      }
    } on SocketException catch (e) {
      developer.log('SocketException: ${e.toString()}');
      return null;
    } on Exception catch (e) {
      developer.log('Exception: ${e.toString()}');
      return null;
    }
  }
}
