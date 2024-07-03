// a stateful widget that accepts a child

import 'package:dating_made_better/hooks/socket.dart';
import 'package:flutter/material.dart';

class Parent extends StatefulWidget {
  final Widget child;
  const Parent({required this.child, super.key});

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  @override
  void initState() {
    connectSocket(2, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
