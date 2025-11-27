import 'package:ev_point/controllers/station/route_map_provider.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places_sdk;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class RouteMapScreen extends StatefulWidget {
  final places_sdk.LatLng source;
  final places_sdk.LatLng destination;

  const RouteMapScreen({
    super.key,
    required this.source,
    required this.destination,
  });

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) =>
              RouteMapProvider()..loadRoute(widget.source, widget.destination),
      child: Scaffold(
        body: Consumer<RouteMapProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.source.lat, widget.source.lng),
                    zoom: 12,
                  ),
                  onMapCreated: provider.onMapCreated,
                  markers: provider.markers,
                  polylines: provider.polylines,
                  myLocationEnabled: !provider.isNavigating,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),

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
                  ),
                ),

                // Custom AppBar
                Positioned(
                  top: 50.h,
                  left: 20.w,
                  right: 20.w,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Route Search",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: Constants.urbanistFont,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.greyScale900,
                          ),
                        ),
                      ),
                      SizedBox(width: 40.w), // Balance the back button
                    ],
                  ),
                ),

                // Current Location Button
                Positioned(
                  bottom: 250.h, // Adjust based on bottom card height
                  right: 20.w,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      provider.animateToCurrentLocation();
                    },
                    child: Icon(Icons.my_location, color: AppColor.primary_900),
                  ),
                ),

               

                // Bottom Card
                Positioned(
                  bottom: 30.h,
                  left: 20.w,
                  right: 20.w,
                  child: Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (provider.isLoading)
                          Center(child: CircularProgressIndicator())
                        else if (provider.hasArrived)
                          Column(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: AppColor.primary_900,
                                size: 50.sp,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "You reached at your destination",
                                style: TextStyle(
                                  fontFamily: Constants.urbanistFont,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              CustomButton(
                                title: "Done",
                                textColor: AppColor.white,
                                boldText: true,
                                borderRadius: 30.r,
                                buttonColor: AppColor.primary_900,
                                onTapCallback: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          )
                        else
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Distance",
                                        style: TextStyle(
                                          fontFamily: Constants.urbanistFont,
                                          color: AppColor.greyScale700,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        provider.distance,
                                        style: TextStyle(
                                          fontFamily: Constants.urbanistFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 40.h,
                                    width: 1,
                                    color: AppColor.greyScale200,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Duration",
                                        style: TextStyle(
                                          fontFamily: Constants.urbanistFont,
                                          color: AppColor.greyScale700,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        provider.duration,
                                        style: TextStyle(
                                          fontFamily: Constants.urbanistFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              CustomButton(
                                title:
                                    provider.isNavigating
                                        ? "Stop Navigation"
                                        : "Start",
                                textColor: AppColor.white,
                                borderRadius: 30.r,
                                buttonColor:
                                    provider.isNavigating
                                        ? Colors.red
                                        : AppColor.primary_900,
                                onTapCallback: () {
                                  if (provider.isNavigating) {
                                    provider.stopNavigation();
                                  } else {
                                    provider.startNavigation();
                                  }
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
