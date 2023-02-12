import 'package:flutter/material.dart';

class InitialDetailsScreen extends StatelessWidget {
  const InitialDetailsScreen({super.key});
  static const routeName = '/initial-details-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stumble!'),

      ),
      body: Column(children: [
        // Add information about stumble here.
      ]),
    );
  }
}
