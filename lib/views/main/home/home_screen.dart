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
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
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
    // final showMap = context.watch<HomeProvider>().isShowMap;
    return Scaffold(
      // backgroundColor: Colors.teal,
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return LazyLoadIndexedStack(
            index: homeProvider.currentIndex,
            children: [

               StationMapScreen(), 
               StationListScreen(),

            ],
          );
        },
      ),
    );
  }
}
