import 'package:flutter/material.dart';

class MySaveScreen extends StatefulWidget {
  const MySaveScreen({super.key});

  @override
  State<MySaveScreen> createState() => _MySaveScreenState();
}

class _MySaveScreenState extends State<MySaveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("My Saved"),
      ),
    );
  }
}