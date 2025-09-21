import 'dart:developer';

import 'package:ev_point/controllers/home_provider.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/permission_manager.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/views/main/home/station_list_screen.dart';
import 'package:ev_point/views/main/home/station_map_screen.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:ev_point/widgets/dialogbox/custom_dialogbox.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      var status = await PermissionManager.checkPermission(Permission.location);
      if ( status.isDenied || status.isPermanentlyDenied ) {
        showDialogs();  
      } 
      
    });
  }

  void showDialogs() {
    customDialogBox(
      context: context,
      image: "${Constants.imagePath}location.png",
      title: "Enable Location",
      subTitleTextAlign: TextAlign.center,
      subTitle:
          "We need access to your location to find EV charging stations around you.",
      child: Column(
        spacing: 10.h,
        mainAxisSize: MainAxisSize.min,
        children: [
          // enable location button
          CustomButton(
            title: "Enable Location",
            buttonColor: AppColor.primary_900,
            borderRadius: 25.r,
            textColor: AppColor.white,
            onTapCallback: () async{

              await PermissionManager.requestPermission(Permission.location);
              Navigator.pop( context  );

            },
          ),

          // cancel button
          CustomButton(
            title: "Cancel",
            buttonColor: AppColor.primary_50,
            borderRadius: 25.r,
            textColor: AppColor.primary_900,
            onTapCallback: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showMap = context.watch<HomeProvider>().isShowMap;
    return Scaffold(
      // backgroundColor: Colors.teal,
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return Stack(
            children: [

              homeProvider.isShowMap ? StationMapScreen() : StationListScreen(),

              // search textfield
              

              // // list or map icon
              // Positioned(
              //   bottom: 20.h,
              //   right: 15.w,
              //   child: InkWell(
              //     onTap: () {
              //       homeProvider.changeTab();
              //     },
              //     child: Container(
              //       height: 50,
              //       width: 50,
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         gradient: LinearGradient(
              //           colors: [
              //             AppColor.primary_900.withAlpha(70),
              //             AppColor.primary_900,
              //           ],
              //           begin: Alignment.topLeft,
              //           end: Alignment.bottomRight,
              //         ),

              //         boxShadow: [
              //           BoxShadow(
              //             color: AppColor.greyScale300,
              //             offset: Offset(0, 3),
              //             blurRadius: 20,
              //           ),
              //         ],
              //       ),
              //       child: AnimatedSwitcher(
              //         duration: Duration(milliseconds: 500),
              //         transitionBuilder: (child, animation) {
              //           return FadeTransition(opacity: animation, child: child);
              //         },
              //         child:
              //             homeProvider.isShowMap
              //                 ? Icon(
              //                   key: const ValueKey(1),
              //                   Icons.list,
              //                   color: AppColor.white,
              //                 )
              //                 : Icon(
              //                   key: const ValueKey(2),
              //                   Icons.map,
              //                   color: AppColor.white,
              //                 ),
              //       ),
              //     ),
              //   ),
              // ),

              // // location icon
              // AnimatedPositioned(
              //   duration: Duration(milliseconds: 800),
              //   bottom: 20.h,
              //   // bottom: homeProvider.isShowMap ? 20.h : -30.h,
              //   right: homeProvider.isShowMap ? 70.h : -50.h,
              //   // right: 70.h,
              //   curve: Curves.easeOut,
              //   child: InkWell(
              //     onTap: () {},
              //     child: Container(
              //       // duration: Duration(milliseconds: 800),
              //       width: 50,
              //       height: 50,
              //       decoration: BoxDecoration(
              //         color: AppColor.primary_900,
              //         shape: BoxShape.circle,
              //         gradient: LinearGradient(
              //           colors: [
              //             AppColor.primary_900.withAlpha(70),
              //             AppColor.primary_900,
              //           ],
              //           begin: Alignment.topLeft,
              //           end: Alignment.bottomRight,
              //         ),

              //         boxShadow: [
              //           BoxShadow(
              //             color: AppColor.greyScale300,
              //             offset: Offset(0, 3),
              //             blurRadius: 20,
              //           ),
              //         ],
              //       ),
              //       child: Icon(
              //         Icons.my_location_rounded,
              //         color: AppColor.white,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}
