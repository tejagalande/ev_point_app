import 'dart:developer';

import 'package:ev_point/controllers/home_provider.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class StationListScreen extends StatefulWidget {
  const StationListScreen({super.key});

  @override
  State<StationListScreen> createState() => _StationListScreenState();
}
class _StationListScreenState extends State<StationListScreen> {

  @override
  void initState() {
    log("StationListScreen initState called");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              spacing: 10.h,
              children: [
                SizedBox(height: 10.h,),
            
                // search textfield and filter icon
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    spacing: 10.w,
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15.r),
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(15.r),
                            decoration: BoxDecoration(
                              color: AppColor.greyScale100,
                              borderRadius: BorderRadius.circular(15.r)
                            ),
                            child: Row(
                              spacing: 10.w,
                              children: [
                                SvgPicture.asset("${Constants.iconPath}search.svg", height: 30,),
                                Text("Search Station", style: TextStyle(fontFamily: Constants.urbanistFont),)
                              ],
                            )
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Container(
                          padding: EdgeInsets.all(15.r),
                          decoration: BoxDecoration(
                            color: AppColor.greyScale100,
                            borderRadius: BorderRadius.circular(15.r)
                          ),
                          child: SvgPicture.asset("${Constants.iconPath}search_filter.svg")
                        ),
                      ),
                    ],
                  ),
                ),
            
                // list
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal:  10.w),
                    child: const Divider(thickness: 0.5,),
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: InkWell(
                        onTap: () {
                          
                        },
                        child: Row(
                          spacing: 10.w,
                          children: [
                            SvgPicture.asset(
                              "${Constants.iconPath}free_station_icon.svg", 
                              height: 30.h,
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Station Name", style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                Text("Address", style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 14.sp,color: AppColor.greyScale700 ,fontWeight: FontWeight.w500),),
                              ],
                            ),
                            const Spacer(),
                        
                            Icon(Icons.chevron_right_rounded)
                        
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

                          // list or map icon
              Positioned(
                bottom: 20.h,
                right: 15.w,
                child: InkWell(
                  onTap: () {
                    // homeProvider.changeTab();
                    context.read<HomeProvider>().changeTab();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColor.primary_900.withAlpha(70),
                          AppColor.primary_900,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: AppColor.greyScale300,
                          offset: Offset(0, 3),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Icon(
                                key: const ValueKey(2),
                                Icons.map,
                                color: AppColor.white,
                              ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      )
    );
  }
}