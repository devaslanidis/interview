import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview/models/followers_model.dart';
import '../userAuth/userName.dart';

class FetchFollowers extends ChangeNotifier {
  final List <FollowersModel> _followersData = [];
  List <FollowersModel> get followersData => _followersData;

  fetchFollowers() async {
    try{
      //Save the user login name in loginName value.
      final loginName = UserName.username;
      String url = 'https://api.github.com/users/$loginName/followers';
      //Start to connect with followers api url.
      final response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
      });

//fetch followers data if status code is 200.
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        for (var item in body) {
          _followersData.add(FollowersModel.fromJson(item));
          notifyListeners();
        }
      } else {
        throw Exception('Failed to fetch user data');
      }
    }on SocketException catch (e) {
      debugPrint('Error:::[Follower Provider] $e');
    }
  }
}
