import 'dart:async';
import 'dart:math' as math;
import 'dart:developer';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ev_point/controllers/home/station_list_provider.dart';
import 'package:ev_point/controllers/home/station_map_provider.dart';
import 'package:ev_point/controllers/home_provider.dart';
import 'package:ev_point/routes/app_pages.dart';
import 'package:ev_point/routes/app_routes.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/views/main/home/home_screen.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:ev_point/widgets/rating_star.dart';
import 'package:ev_point/widgets/route_navigator.dart';
import 'package:ev_point/widgets/station_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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
  final Set<Marker> _markers = {};
  StationMapProvider? mapProvider;
  StationListProvider? listProvider;

  @override
  void initState() {
    log("StationMapScreen initState called");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapProvider = Provider.of<StationMapProvider>(context, listen: false);
      // mapProvider = context.read<StationMapProvider>();
    listProvider = Provider.of<StationListProvider>(context, listen: false);

    // _setUpMarkerData();
    },);

    super.initState();
  }

  void _setUpMarkerData(StationMapProvider provider) async {
    final customIcon = await BitmapDescriptor.asset(
      createLocalImageConfiguration(context, size: Size(50, 50)),
      '${Constants.iconPath}free_station_icon.png',
    );

    var stationMarkerList =
        listProvider!.stationList!.map((e) {
          var lat = e.location!.split(',')[0];
          var long = e.location!.split(',')[1];

          return MarkerData(
            id: e.id!.toString(),
            position: LatLng(double.parse(lat), double.parse(long)),
            title: "Station ${e.id}",
            snippet: e.name ?? "",
            icon: customIcon,
          );
        }).toList();

    provider.markerDataList = stationMarkerList;

    // _markerDataList = stationMarkerList;
  }

  @override
  Widget build(BuildContext context) {
        final screenWidth = ScreenUtil().screenWidth;
    final screenHeight = ScreenUtil().screenHeight;
    return Scaffold(
      backgroundColor: AppColor.white,

      body: Consumer<StationMapProvider>(
        builder: (context, value, child) {
          log("liteModeEnable: ${value.liteModeEnable}");
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: value.initialPosition,
                onMapCreated: (controller) {
                  value.onMapCreated(controller);

                  _setUpMarkerData(value);
                  // Start loading markers after map is ready
                  Future.delayed(Duration(milliseconds: 1000), () {
                    if (!value.isDisposed) {
                      // Choose your loading approach:
                      value.loadMarkersProgressively( ); // Approach 1
                      // OR
                      // provider.loadMarkersWithAnimation(); // Approach 3
                    }
                  });
                },
                liteModeEnabled: false,
                markers: value.markers,
                myLocationEnabled: value.myLocationEnabled,
                myLocationButtonEnabled: false,
                indoorViewEnabled: false,
                buildingsEnabled: false,
                trafficEnabled: false,
                zoomControlsEnabled: value.zoomControlsEnabled,
                mapType: MapType.normal,
                compassEnabled: false,
                onTap: (argument) {
                  value.onMapInteraction();
                },
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                  // Factory<OneSequenceGestureRecognizer>(() => TapGestureRecognizer()),
                  // Factory<OneSequenceGestureRecognizer>(() => ScaleGestureRecognizer()),
                  // Factory<OneSequenceGestureRecognizer>(() => PanGestureRecognizer()),
                  // Factory<OneSequenceGestureRecognizer>(() => VerticalDragGestureRecognizer()),
                  // Factory<OneSequenceGestureRecognizer>(() => HorizontalDragGestureRecognizer()),
                },
                onCameraMove: (position) {
                  // if (!value.liteModeEnable) {
                  value.onMapInteraction();
                  // }
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
                    // location and list icon 
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 10.w,
                        children: [
                          // location icon
                          InkWell(
                            onTap: () {
                              mapProvider!.moveToCurrentLocation();
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
                    
                    // marker window
                    value.selectedMarker != null ?
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
                                    value.selectedMarker!.snippet ,
                                    style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                  SizedBox( 
                                    width: screenWidth * 0.6,
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      listProvider!.stationList?.where((element) => element.id == int.parse(value.selectedMarker!.id) ,).first.address ?? "",
                                      style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 14.sp,color: AppColor.greyScale700 ,fontWeight: FontWeight.w500),
                                      ),
                                  )],
                              ),

                              const Spacer(),

                              RouteNavigator(),
                            ],
                          ),

                          SizedBox(height: 5.h,),

                          // ratings stars
                          RatingStar(rating: '4.5', ratingCount: '120',),

                          SizedBox(height: 5.h,),

                          // available, KM, duration text and icons
                          StationData(stationDistanceInKm: '1.6', stationDuration: '5min', stationStatus: 'Available',),
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
                                    Navigator.pushNamed(context, AppRoutes.stationDetailRoute);
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
                    ) : 
                    SizedBox.shrink()
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // @override
  // void didChangeDependencies() {
  //   mapProvider = Provider.of<StationMapProvider>(context);
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    // context.read<StationMapProvider>().controller?.dispose();
    // mapProvider?.dispose();

    super.dispose();
  }
}
