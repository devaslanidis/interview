import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/repo_model.dart';
import '../userAuth/userName.dart';

class FetchRepos extends ChangeNotifier {

  final List <RepoModel> _reposData = [];
  List <RepoModel> get reposData => _reposData;

  fetchRepos() async {
    try {
      //Save the user login name in loginName value.
      final loginName = UserName.username;
      //Start to connect with repos api url.
      String url = 'https://api.github.com/users/$loginName/repos';
      final response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
      });
//fetch repositories data if status code is 200.
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        for (var item in body) {
          _reposData.add(RepoModel.fromJson(item));
          notifyListeners();
        }
      } else {
        throw Exception('Failed to fetch repositories data');
      }
    }on SocketException catch (e) {
      debugPrint('Error:::[Repositories Provider] $e');
    }
  }
}

