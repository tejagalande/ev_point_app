import 'dart:developer';

import 'package:ev_point/controllers/main_provider.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/views/main/account/account_screen.dart';
import 'package:ev_point/views/main/booking/my_booking_screen.dart';
import 'package:ev_point/views/main/home/home_screen.dart';
import 'package:ev_point/views/main/saved/my_save_screen.dart';
import 'package:ev_point/views/main/wallet/my_wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {

    super.initState();
  }

  final List<Widget> _pages = [
    HomeScreen(),
    MySaveScreen(),
    MyBookingScreen(),
    MyWalletScreen(),
    AccountScreen()
  ];

  final List<Map<String, String>> _tabs = [ 
    {"title" : "Home", "icon" : "${Constants.iconPath}home_icon.svg", "filled_icon" : "${Constants.iconPath}home_filled_icon.svg"},
    {"title" : "Saved", "icon" : "${Constants.iconPath}bookmark_icon.svg", "filled_icon" : "${Constants.iconPath}bookmark_filled_icon.svg"},
    {"title" : "My Booking", "icon" : "${Constants.iconPath}booking_icon.svg", "filled_icon" : "${Constants.iconPath}booking_filled_icon.svg"},
    {"title" : "My Wallet", "icon" : "${Constants.iconPath}wallet_icon.svg", "filled_icon" : "${Constants.iconPath}wallet_filled_icon.svg"},
    {"title" : "Account", "icon" : "${Constants.iconPath}profile_icon.svg", "filled_icon" : "${Constants.iconPath}profile_filled_icon.svg"},
     ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 10.h) ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _tabs.indexed.map((e) {
            return InkWell(
              onTap: () {
                log("current tab index: ${e.$1}");
                context.read<MainProvider>().changeTab(e.$1);
              },
              child: Consumer<MainProvider>(
                builder: (context, value, child) {
                  return Column(
                spacing: 5.h,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset( e.$1 == value.selectedTab ? e.$2['filled_icon']!  : e.$2['icon']!, ),
                  Text(e.$2['title']!, style: TextStyle(fontFamily: Constants.urbanistFont, fontWeight: FontWeight.w500  , color: e.$1 == value.selectedTab ? AppColor.primary_900 : AppColor.greyScale500 ),)
                ],
              );
                },
              )
            );
          },).toList()
            
        ),
      ),
      body: Consumer<MainProvider>(
        builder: (context, value, child) {
          return Center(
            child: _pages[value.selectedTab],
          );
        },
      )
    );
  }
}