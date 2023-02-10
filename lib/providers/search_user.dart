import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview/models/user_model.dart';


class SearchUser extends ChangeNotifier {
  final List <UserModel> _userData = [];
  List <UserModel> get userData => _userData;
  String? _message;
  String? get message => _message;

  searchUser(String loginName) async {
    try {
      String url = 'https://api.github.com/users/$loginName';

      //Start to connect with user api url.
      final response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
      });

//fetch user data if status code is 200.
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        _userData.add(UserModel.fromJson(body));
        notifyListeners();
      }else if(response.statusCode == 404) {
        var body = jsonDecode(response.body);

         _message = body['message'];
          notifyListeners();
      } else {
        throw Exception('Failed to fetch user data');
      }
    }on SocketException catch (e) {
      debugPrint('Error:::[Search Provider] $e');
    }
  }
}
