import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
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
    // addToCart(widget.imageUrl, widget.price);
  }

  // Method to add item to cart
  void addToCart(String imageUrl, double price) {
    setState(() {
      cart.add({'imageUrl': imageUrl, 'price': price});
      total = cart.fold(0, (sum, item) => sum + item['price']);
    });
  }

  double totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    cart = ModalRoute.of(context)!.settings.arguments
            as List<Map<String, dynamic>>? ??
        [];

// Iterate through the cart and sum the prices
    totalPrice = 0.0;
    for (var item in cart) {
      totalPrice += item['price'] as double; // Ensure 'price' is of type double
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Screen'),
      ),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Total $totalPrice',
                    style: TextStyle(fontSize: 18),
                  ))),
          ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(
                  cart[index]['imageUrl'],
                  width: 40.0,
                ),
                title: Text(cart[index]['price'].toString()),
              );
            },
          ),
        ],
      ),
    );
  }
}
