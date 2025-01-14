import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? dogImageUrl;
  List<String> history = [];
  List<Map<String, dynamic>> cart = [];
  final String imageUrl = "https://example.com/product_image.jpg";
  final double price = 19.99;

  Future<void> fetchDogImage() async {
    final response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        dogImageUrl = data['message'];
        history.add(dogImageUrl!);
      });
    } else {
      throw Exception('Failed to load dog image');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDogImage(); // Fetch an initial image on startup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () =>
                Navigator.pushNamed(context, '/history', arguments: history),
          ),
          IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () async {
                // When the button is pressed, navigate to the CartPage with product details
                Navigator.pushNamed(context, '/cart', arguments: cart);

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CartPage(
                //       imageUrl: imageUrl,
                //       price: price,
                //     ),
                //   ),
                // );
                // Navigator.pushNamed(context, '/cart',
                //     arguments: {'imageUrl': dogImageUrl, 'price': 10.0});
              }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dogImageUrl != null
                ? Image.network(
                    dogImageUrl!,
                    height: 250,
                  )
                : const CircularProgressIndicator(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchDogImage,
              child: const Text('Fetch New Dog Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                cart.add({'imageUrl': dogImageUrl, 'price': price});
                SnackBar snackBar = const SnackBar(
                  backgroundColor: Colors.green,
                  content: Center(child: Text('Item added to cart!')),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  snackBar,
                );

                // Navigator.pushNamed(context, '/cart',
                //     arguments: {'imageUrl': dogImageUrl, 'price': 10.0});
              },
              child: const Text('Add to Cart (\$10.0)'),
            ),
          ],
        ),
      ),
    );
  }
}
