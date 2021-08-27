import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/providers/auth_provider.dart';
import 'package:gsg_firebase1/Auth/ui/screens/profile_screen.dart';
import 'package:gsg_firebase1/Auth/ui/screens/users_screen.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/custom_text_field.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/user_info_card.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen();

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _currentIndex = 0;
  final _screens = [
    ProfileScreen(),
    UsersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (ctx, authProvider, _) {
      authProvider.getAllUsers();
      return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          body: _screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'profile'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt), label: 'profile'),
            ],
          ),
        ),
      );
    });
  }
}
