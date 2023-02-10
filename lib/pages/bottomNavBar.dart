import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview/pages/followers.dart';
import 'package:interview/pages/profile.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'repositories.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final _bottomNavbarController = PersistentTabController();

  List<Widget> _buildScreens() {
    return [
      const Profile(),
      const Followers(),
      const Repos(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
         icon: const Icon(CupertinoIcons.profile_circled),
          activeColorPrimary: Colors.black,
          title:'Profile',
          textStyle: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.favorite_border_rounded),
          activeColorPrimary: Colors.black,
          title:'Followers',
          textStyle: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.file_copy),
          activeColorPrimary: Colors.black,
          title:'Repositories',
          textStyle: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PersistentTabView(
          context,
          controller: _bottomNavbarController,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,

          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          handleAndroidBackButtonPress: true,
          // Default is true.
          resizeToAvoidBottomInset: true,
          // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true,
          // Default is true.
          hideNavigationBarWhenKeyboardShows: true,
          // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Theme.of(context).scaffoldBackgroundColor,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle
              .style3, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
}
