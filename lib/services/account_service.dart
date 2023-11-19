import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ct484_project/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  Future<dynamic> verifyCredential(User data) async {
    final requestBody = data.toJson();
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/accounts/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );
    dynamic token;

    if (response.statusCode == 200) {
      token = jsonDecode(response.body.toString())['token'];
    }

    return token;
  }

  Future<dynamic> createUser(User data) async {
    final requestBody = data.toJson();
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/accounts/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );
    dynamic token;

    if (response.statusCode == 200) {
      token = jsonDecode(response.body.toString())['token'];
    }

    return token;
  }

  Future<void> saveToken(newValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (newValue != null) {
      await prefs.setString('token', newValue);
    } else {
      await prefs.remove('token');
    }
  }

  Future<String?> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? isDarkTheme = prefs.getString('token');
    return isDarkTheme;
  }

  Future<dynamic> retrieveUserData(token) async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/accounts/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': 'token=$token',
      },
    );
    dynamic user;
    if (response.statusCode == 200) {
      user = User.fromJson(jsonDecode(response.body.toString()));
    }
    return user;
  }

  Future<void> updateUserData(newUser, file, token, user) async {
    var request = http.MultipartRequest(
        "PUT", Uri.parse("http://localhost:3000/api/accounts/"));

    var headers = {
      'cookie': 'token=$token',
    };
    request.headers.addAll(headers);

    if (newUser.usName != "") {
      request.fields["us_name"] = newUser.usName;
    } else {
      request.fields["us_name"] = user.usName;
    }
    if (newUser.usGender != "") {
      request.fields["us_gender"] = newUser.usGender;
    } else {
      request.fields["us_gender"] = user.usGender;
    }

    if (file != null) {
      var pic = await http.MultipartFile.fromPath("userImage", file.path);
      request.files.add(pic);
    }

    await request.send();
  }
}
