import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserRepository {
  // Get a writable file location using path_provider
  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/users.txt');
    print('Storing data at: ${file.absolute.path}');
    return file;
  }

  // Save user data
  static Future<void> saveUser(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      final file = await _getFile();
      final userData = '$fullName|$email|$password\n';
      await file.writeAsString(userData, mode: FileMode.append);
      print('Data saved successfully to: ${file.path}');
    } catch (e) {
      print('Error saving data: $e');
      rethrow;
    }
  }

  // Retrieve all user entries
  static Future<List<String>> getUsers() async {
    final file = await _getFile();
    if (await file.exists()) {
      final contents = await file.readAsString();
      return contents.split('\n').where((line) => line.isNotEmpty).toList();
    }
    return [];
  }
}
