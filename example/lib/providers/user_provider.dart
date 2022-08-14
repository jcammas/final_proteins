// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import './auth_provider.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  final String host = 'http://127.0.0.1';
  late User? user;
  late AuthProvider authProvider;

  update(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
    if (authProvider.isLoggedin == true) {
      fetchCurrentUser();
    }
  }

  Future<void> fetchCurrentUser() async {
    http.Response response = await http.get(
      Uri.parse('$host/api/user/current'),
      headers: {'authorization': 'Bearer ${authProvider.token}'},
    );
    if (response.statusCode == 200) {
      updateUser(
        User.fromJson(
          json.decode(response.body),
        ),
      );
    }
  }

  void updateUser(User updatedUser) {
    user = updatedUser;
    notifyListeners();
  }
}
