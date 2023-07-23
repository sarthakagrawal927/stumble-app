import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage
const storage = FlutterSecureStorage();

// Write value
Future<void> writeSecureData(String key, String value) async {
  final writeData = await storage.write(key: key, value: value);
  return writeData;
}

// Read value
Future<String?> readSecureData(String key) async {
  final readData = await storage.read(key: key);
  return readData;
}
