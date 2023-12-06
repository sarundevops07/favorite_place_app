import 'package:flutter/material.dart';

class YourPlaceScreen extends StatelessWidget {
  const YourPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('My Office'),
          )
        ],
      ),
    );
  }
}
