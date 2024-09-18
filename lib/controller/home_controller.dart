import 'dart:convert';
import 'dart:developer' as developer;
import 'package:fake_e_commerce/model/product.dart';
import 'package:http/http.dart' as http;

class HomeController {
  Future<List<Product>?> getProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    final responseData = json.decode(response.body);
    try {
      if (response.statusCode == 200) {
        developer.log('Response Data Get res answer: $responseData');

        // Ensure that `responseData['data']` is a map and not null
        final Map<String, dynamic> dataParsing = responseData['data'];

        // Iterate through the values of the map and create a list of AnswerModel
        List<Product> datalist = dataParsing.values.map<Product>((map) {
          return Product.fromMap(map);
        }).toList();

        return datalist;
      } else {
        developer.log('Response Error: $responseData');
        return null;
      }
    } on Exception catch (e) {
      developer.log('Error: ${e.toString()}');
      return null;
    }
  }
}
