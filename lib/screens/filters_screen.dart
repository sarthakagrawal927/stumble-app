import 'package:flutter/material.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});
  static const routeName = "/filters-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(26, 28, 29, 1),
      appBar: AppBar(
        centerTitle: true,
        actions: [],
        title: Text('Filters'),
        backgroundColor: Theme.of(context).splashColor,
      ),
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                Text('Who you want to date:'),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
