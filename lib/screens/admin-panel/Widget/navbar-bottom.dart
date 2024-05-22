// ignore_for_file: prefer_const_constructors

import 'package:ecom_app/main.dart';
import 'package:ecom_app/screens/Profile/profile.dart';
import 'package:ecom_app/screens/admin-panel/admin-screen.dart';
import 'package:ecom_app/screens/user-panel/cart/cart.dart';
import 'package:ecom_app/screens/user-panel/favourite/favourite.dart';
import 'package:ecom_app/screens/user-panel/home-screen.dart';
import 'package:flutter/material.dart';
import 'package:ecom_app/utils/app-constant.dart';

class NavBarAdmin extends StatefulWidget {
  const NavBarAdmin({super.key});

  @override
  State<NavBarAdmin> createState() => _NavBarAdminState();
}

class _NavBarAdminState extends State<NavBarAdmin> {

  List screens = const [
                HomeScreen(),
                Scaffold(),
                MyApp(),
                MyCart(),
                MyProfile(),
              ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
          currentIndex = 2;
        });
      },
      shape: const CircleBorder(),
      backgroundColor: AppConstant.appSecondaryColor, child: Icon(Icons.home, color: Colors.white, size: 45,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 60,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 10, clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          IconButton(
          onPressed: (){
            setState(() {
              currentIndex = 0;
            });
          }, 
          icon: Icon(
            Icons.home, 
            size: 30, 
            color: currentIndex == 0 ?AppConstant.appSecondaryColor : Colors.grey.shade400,
        )
        ),
         IconButton(
          onPressed: (){
            setState(() {
              currentIndex = 1;
            });
          }, 
          icon: Icon(
            Icons.assessment_outlined, 
            size: 30, 
            color: currentIndex == 1 ?AppConstant.appSecondaryColor : Colors.grey.shade400,
        )
        ),
        const SizedBox(width: 15,
        ),
         IconButton(
          onPressed: (){
            setState(() {
              currentIndex = 3;
            });
          }, 
          icon: Icon(
            Icons.camera_alt_outlined, 
            size: 30, 
            color: currentIndex == 3 ?AppConstant.appSecondaryColor : Colors.grey.shade400,
        )
        ),
         IconButton(
          onPressed: (){
            setState(() {
              currentIndex = 4;
            });
          }, 
          icon: Icon(
            Icons.person, 
            size: 30, 
            color: currentIndex == 4 ?AppConstant.appSecondaryColor : Colors.grey.shade400,
        )
        )
        ],
        ),
      ),
      body: screens[currentIndex],
    );
  }
}