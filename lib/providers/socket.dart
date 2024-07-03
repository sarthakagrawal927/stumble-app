import 'package:flutter/material.dart';

class SocketProvider with ChangeNotifier {
  int newMessageCount;

  SocketProvider({this.newMessageCount = 0});

  void incrementMessageCount() {
    newMessageCount++;
    notifyListeners();
  }

  void resetMessageCount() {
    newMessageCount = 0;
    notifyListeners();
  }
}
