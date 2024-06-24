import 'package:documind/screens/dashboard_screen/categories/categories_screen.dart';
import 'package:documind/screens/dashboard_screen/history/history_screen.dart';
import 'package:documind/screens/dashboard_screen/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constant/colors.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  int selectedIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    CategoriesScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
            setState(() {
              selectedIndex = index;
            });
        },
        currentIndex: selectedIndex,
        selectedItemColor: Colors.purple,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Categories',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.manage_search),
          //   label: 'history',
          // ),
        ],
      ),
    );
  }
}
