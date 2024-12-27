import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final String imageUrl;
  final double price;

  CartPage({required this.imageUrl, required this.price});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // This list will store the cart items
  List<Map<String, dynamic>> cart = [];

  // Variable to calculate the total price
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    // Initially, add the product passed to the CartPage to the cart list
    addToCart(widget.imageUrl, widget.price);
  }

  // Method to add item to cart
  void addToCart(String imageUrl, double price) {
    setState(() {
      cart.add({'imageUrl': imageUrl, 'price': price});
      total = cart.fold(0, (sum, item) => sum + item['price']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final imageUrl = cart[index]['imageUrl'];
                final price = cart[index]['price'];
                return ListTile(
                  leading: Image.network(imageUrl),
                  title: Text('Price: \$${price.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
