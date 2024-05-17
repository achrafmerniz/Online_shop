// import 'package:clothes_app/users/userPreferences/current_user.dart';
import 'package:clothes_app/users/fragments/favorite_fragment_screen.dart';
import 'package:clothes_app/users/fragments/home_fragment_screen.dart';
import 'package:clothes_app/users/fragments/order_fragment_screen.dart';
import 'package:clothes_app/users/fragments/profile_fragment_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class DashboardOfFragments extends StatelessWidget {
 final List<Widget> _fragmentsScreens = [
    HomeFragmentScreen(),
    FavoriteFragmentScreen(),
    OrderFragmentScreen(),
    ProfileFragmentScreen(),

  ];

  final List<Map<String, dynamic>> _navigationButtonPropreties = [
    {
      'active_icon': Icons.home,
      'non_active_icon': Icons.home_outlined,
      'label': "Home",
    },
    {
      'active_icon': Icons.favorite,
      'non_active_icon': Icons.favorite_border,
      'label': "Favorite",
    },
    {
      'active_icon': FontAwesomeIcons.boxOpen,
      'non_active_icon': FontAwesomeIcons.box,
      'label': "Orders",
    },
    {
      'active_icon': Icons.person,
      'non_active_icon': Icons.person_outline,
      'label': "Profile",
    }
  ];
 final RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          ()=> _fragmentsScreens[_indexNumber.value],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.grey.shade500,
          currentIndex: _indexNumber.value,
          onTap: (value) {
            _indexNumber.value = value;
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.orange,
          items: List.generate(
            _navigationButtonPropreties.length,
            (index) {
              var navBtnProprety = _navigationButtonPropreties[index];
              return BottomNavigationBarItem(
                icon: Icon(navBtnProprety["non_active_icon"]),
                activeIcon: Icon(navBtnProprety["active_icon"]),
                label: navBtnProprety["label"],
              );
            },
          ),
        ),
      ),
    );
  }
}