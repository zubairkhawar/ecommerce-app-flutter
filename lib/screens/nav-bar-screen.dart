// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:ecom_app/screens/Profile/profile.dart';
import 'package:ecom_app/screens/Provider/favourite-provider.dart';
import 'package:ecom_app/screens/admin-panel/admin-screen.dart';
import 'package:ecom_app/screens/auth/login/login-screen.dart';
import 'package:ecom_app/screens/user-panel/cart/cart.dart';
import 'package:ecom_app/screens/user-panel/favourite/favourite.dart';
import 'package:ecom_app/screens/user-panel/home-screen.dart';
import 'package:flutter/material.dart';
import 'package:ecom_app/utils/app-constant.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  List<Widget> screens = const [
    HomeScreen(),
    Favourite(), 
    AdminScreen(),
    MyCart(),
    MyProfile(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            currentIndex = 2;
          });
          bool isLoggedIn = await checkIfLoggedIn();

          if (isLoggedIn) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        },
        shape: const CircleBorder(),
        backgroundColor: AppConstant.appSecondaryColor,
        child: Icon(Icons.add, color: Colors.white, size: 45,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 60,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              icon: Icon(
                Icons.home,
                size: 30,
                color: currentIndex == 0 ? AppConstant.appSecondaryColor : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              icon: Icon(
                Icons.favorite_border,
                size: 30,
                color: currentIndex == 1 ? AppConstant.appSecondaryColor : Colors.grey.shade400,
              ),
            ),
            const SizedBox(width: 15,),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 3;
                });
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
                color: currentIndex == 3 ? AppConstant.appSecondaryColor : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 4;
                });
              },
              icon: Icon(
                Icons.person,
                size: 30,
                color: currentIndex == 4 ? AppConstant.appSecondaryColor : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      body: screens[currentIndex],
    );
  }

  Future<bool> checkIfLoggedIn() async {
    return true;
  }
}
