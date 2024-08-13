import 'package:e_com_pay/screen/home_screen.dart';
import 'package:e_com_pay/screen/profile_screen.dart';
import 'package:flutter/material.dart';


import '../constant/colors.dart';
import 'category_scren.dart';

class BottemBarTabs extends StatefulWidget {
  const BottemBarTabs({super.key});
  static final List<Widget> _widghetOption=[
    const HomeScreen(),
    const CategoryScren(),
    const ProfileScreen(),
  ];

  @override
  State<BottemBarTabs> createState() => _BottemBarTabsState();
}

class _BottemBarTabsState extends State<BottemBarTabs> {
  int _selectedIndex=0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: BottemBarTabs._widghetOption[_selectedIndex],
      body: IndexedStack(
        index: _selectedIndex,
        children: BottemBarTabs._widghetOption,
      ),

      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: whitecoloe,
          currentIndex: _selectedIndex,
          
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home,color: Colors.indigo,),
                label: "Home"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                activeIcon: Icon(Icons.category,color: Colors.indigo,),
                label: "Category"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                activeIcon: Icon(Icons.person,color: Colors.indigo,),
                label: "Profile"
            ),
          ]
      ),
    );
  }
}
