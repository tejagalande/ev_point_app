import 'dart:async';
import 'dart:math' as math;
import 'dart:developer';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ev_point/controllers/home_provider.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/views/main/home/home_screen.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class StationMapScreen extends StatefulWidget {
  const StationMapScreen({super.key});

  @override
  State<StationMapScreen> createState() => _StationMapScreenState();
}

class _StationMapScreenState extends State<StationMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.4219999, -122.0862462),
    zoom: 7.0,
  );
  final Set<Marker> _markers = {};
  bool _liteModeEnable = true;

  @override
  void initState() {
    log("StationMapScreen initState called");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,

      body: Stack(
        children: [
          GoogleMap(
            liteModeEnabled: _liteModeEnable,

            initialCameraPosition: _initialPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },

            markers: _markers,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            indoorViewEnabled: false,
            buildingsEnabled: false,
            trafficEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            compassEnabled: false,
            onTap: (LatLng position) {
              // Hide search results when tapping on map
              setState(() {
                // _showResults = false;
                _liteModeEnable = false;
              });
            },
          ),

          // search textfield
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 110,
              decoration: BoxDecoration(
                gradient: Constants.mapSearchLinearGradient,
              ),
              child: Padding(
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
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Row(
                            spacing: 10.w,
                            children: [
                              SvgPicture.asset(
                                "${Constants.iconPath}search.svg",
                                height: 30,
                              ),
                              Text(
                                "Search Station",
                                style: TextStyle(
                                  fontFamily: Constants.urbanistFont,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Container(
                        padding: EdgeInsets.all(15.r),
                        decoration: BoxDecoration(
                          color: AppColor.greyScale100,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: SvgPicture.asset(
                          "${Constants.iconPath}search_filter.svg",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // charging station card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 10.w,
                    children: [
                      // location icon
                      InkWell(
                        onTap: () {},
                        child: Container(
                          // duration: Duration(milliseconds: 800),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColor.primary_900,
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
                          child: Icon(
                            Icons.my_location_rounded,
                            color: AppColor.white,
                          ),
                        ),
                      ),

                      // list icon
                      InkWell(
                        onTap: () {
                          context.read<HomeProvider>().changeTab();
                        },
                        child: Container(
                          // duration: Duration(milliseconds: 800),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColor.primary_900,
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
                          child: Icon(
                            Icons.format_list_bulleted,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  margin: EdgeInsets.all(10.r),
                  padding: EdgeInsets.all(15.r),
                  child: Column(
                    
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // station name, address text
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Station Name",
                                style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 20.sp, fontWeight: FontWeight.bold),), 
                              Text(
                                "Address",
                                style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 14.sp,color: AppColor.greyScale700 ,fontWeight: FontWeight.w500),
                                )],
                          ),

                          const Spacer(),

                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: AppColor.primary_900,
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  AppColor.primary_900.withAlpha(70),
                                  AppColor.primary_900,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Transform.rotate(
                              angle: 13.2,
                              child: Icon(
                                Icons.navigation,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5.h,),

                      // ratings stars
                      Row(
                        spacing: 5.w,
                        children: [
                          Text("3.5", style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 14.sp,fontWeight: FontWeight.w600 ,color: AppColor.greyScale700),),
                          RatingBar.readOnly(
                            filledIcon: Icons.star_rounded,
                            filledColor: AppColor.primary_900,
                            halfFilledColor: AppColor.primary_900,
                            isHalfAllowed: true,
                            size: 25,
                            halfFilledIcon: Icons.star_half_rounded,
                            emptyIcon: Icons.star_border_rounded,
                            initialRating: 3.5,
                            maxRating: 5,
                          ),
                          Text("(130 reviews)", style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 14.sp,fontWeight: FontWeight.w500 ,color: AppColor.greyScale600),)
                        ],
                      ),

                      SizedBox(height: 5.h,),

                      // available, KM, duration text and icons
                      Row(
                        spacing: 10.w,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.primary_900,
                              borderRadius: BorderRadius.circular(6.r)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                            child: Text("Available", style: TextStyle(color: AppColor.white, fontSize: 10.sp , fontFamily: Constants.urbanistFont, fontWeight: FontWeight.w600 ),),
                          ),

                          Row(
                            spacing: 3.w,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on_rounded),
                              Text("1.6KM", style: TextStyle(color: AppColor.greyScale700, fontSize: 10.sp , fontFamily: Constants.urbanistFont, fontWeight: FontWeight.w600 ),)
                            ],
                          ),

                          Row(
                            spacing: 3.w,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.directions_car),
                              Text("1.6KM", style: TextStyle(color: AppColor.greyScale700, fontSize: 10.sp , fontFamily: Constants.urbanistFont, fontWeight: FontWeight.w600 ),)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h,),

                      const Divider(thickness: 0.5,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("6 chargers", style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColor.primary_900),),
                          Icon(Icons.chevron_right_rounded, color: AppColor.primary_900,)
                        ],
                      ),

                      const Divider(thickness: 0.5,),

                      SizedBox(height: 5.h,),

                      Row(
                        spacing: 20.w,
                        children: [

                          // view button
                          Expanded(
                            child: CustomButton(
                              title: "View", 
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              buttonColor: AppColor.white,
                              border: Border.all(color: AppColor.primary_900, width: 2.w),
                              borderRadius: 30.r,
                              textColor: AppColor.primary_900,
                              onTapCallback: () {
                                
                              },
                            
                              ),
                          ),

                          // book button
                          Expanded(
                            child: CustomButton(
                              title: "Book", 
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              buttonColor: AppColor.primary_900,
                              textColor: AppColor.white,
                              borderRadius: 30.r,
                              onTapCallback: () {
                                
                              },
                            
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
