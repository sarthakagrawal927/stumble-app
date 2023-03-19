import 'package:flutter/material.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});
  static const routeName = "/filters-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 28, 29, 1),
      appBar: AppBar(
        centerTitle: true,
        actions: const [],
        title: const Text('Filters'),
        backgroundColor: Theme.of(context).splashColor,
      ),
      body: Column(
        children: [
          Card(
            child: Column(
              children: const [
                Text('Who you want to date:'),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
