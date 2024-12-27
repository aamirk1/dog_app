import 'package:dog_app/cartScreen.dart';
import 'package:dog_app/historyScreen.dart';
import 'package:dog_app/homeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DogApp());
}

class DogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dog App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/history': (context) => HistoryPage(),
       '/cart': (context) => CartPage(),
      },
    );
  }
}
