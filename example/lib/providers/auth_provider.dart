// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:proteins_example/models/signin_form_model.dart';
import 'package:proteins_example/models/user_model.dart';
import 'dart:convert';

import '../models/signup_form_model.dart';

class AuthProvider with ChangeNotifier {
  final String host = 'http://127.0.0.1';
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late String? token;
  Timer timer = Timer.periodic(const Duration(minutes: 60), (timer) {
    print("ok");
  });
  bool isLoading = false;
  bool? isLoggedin = true;

  Future<void> initAuth() async {
    try {
      String? oldToken = await storage.read(key: 'token');
      if (oldToken == null) {
        isLoggedin = false;
      } else {
        token = oldToken;
        await refreshToken();
        isLoggedin = true;
        initTimer();
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshToken() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$host/api/auth/refresh-token'),
        headers: {'authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        token = json.decode(response.body);
        storage.write(key: 'token', value: token);
      } else {
        signout();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signup(SignupForm signupForm) async {
    try {
      isLoading = true;
      http.Response response = await http.post(
        Uri.parse('$host/api/user'),
        headers: {'Content-type': 'application/json'},
        body: json.encode(signupForm.toJson()),
      );
      isLoading = false;
      if (response.statusCode != 200) {
        return json.decode(response.body);
      }
      return null;
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

  Future<dynamic> signin(SigninForm signinForm) async {
    try {
      isLoading = true;
      http.Response response = await http.post(
        Uri.parse('$host/api/auth'),
        headers: {'Content-type': 'application/json'},
        body: json.encode(
          signinForm.toJson(),
        ),
      );
      final Map<String, dynamic> body = json.decode(response.body);
      if (response.statusCode == 200) {
        final User user = User.fromJson(body['user']);
        token = body['token'];
        storage.write(key: 'token', value: token);
        isLoggedin = true;
        initTimer();
        return user;
      } else {
        return body;
      }
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

  void signout() {
    isLoggedin = false;
    token = null;
    storage.delete(key: 'token');
    timer.cancel();
  }

  void signoutFingerprint() {}

  void initTimer() {
    timer = Timer.periodic(const Duration(minutes: 10), (timer) {
      refreshToken();
    });
  }
}
