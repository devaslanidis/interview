import 'package:flutter/material.dart';
import 'package:interview/providers/fetch_followers.dart';
import 'package:interview/providers/fetch_repos.dart';
import 'package:interview/providers/fetch_userData.dart';
import 'package:interview/providers/search_user.dart';
import 'package:provider/provider.dart';
import 'pages/bottomNavBar.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => FetchUserData()),
      ChangeNotifierProvider(create: (_) => FetchFollowers()),
      ChangeNotifierProvider(create: (_) => FetchRepos()),
      ChangeNotifierProvider(create: (_) => SearchUser()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interview',
      home: BottomNavbar(),
    );
  }
}
