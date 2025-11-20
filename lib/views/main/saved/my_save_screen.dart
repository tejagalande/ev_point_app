import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/save_station/saved_stations_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/theme/app_color.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/rating_star.dart';
import '../../../widgets/route_navigator.dart';
import '../../../widgets/station_data.dart';

class MySaveScreen extends StatefulWidget {
  const MySaveScreen({Key? key}) : super(key: key);

  @override
  State<MySaveScreen> createState() => _MySaveScreenState();
}

class _MySaveScreenState extends State<MySaveScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SavedStationsProvider(),
      child: Scaffold(
        backgroundColor: AppColor.white,

        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColor.white,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(10).r,
            child: SvgPicture.asset("${Constants.iconPath}logo_evPoint.svg"),
          ),
          title: Text(
            'Saved',
            style: TextStyle(
              fontFamily: Constants.urbanistFont,
              color: AppColor.greyScale900,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                "${Constants.iconPath}search.svg",
                color: AppColor.greyScale900,
                height: 30,
              ),
            ),
          ],
          actionsPadding: EdgeInsets.symmetric(horizontal: 10.w),
        ),
        body: Consumer<SavedStationsProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.savedStations.isEmpty) {
              return Center(
                child: Text(
                  'No saved stations yet',
                  style: TextStyle(
                    fontFamily: Constants.urbanistFont,
                    fontSize: 16.sp,
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric( horizontal: 10.w, vertical: 10.h),
              itemCount: provider.savedStations.length,
              itemBuilder: (context, index) {
                final station = provider.savedStations[index];
                return _ChargingStationCard(
                  station: station,
                  onToggleSave: () => provider.toggleSaveStation(station.id),
                  onView: () {
                    // Navigate to station details
                  },
                  onBook: () {
                    // Navigate to booking screen
                  },
                );
              },
            );
          },
        ),
        // bottomNavigationBar: const _BottomNavBar(),
      ),
    );
  }
}

class _ChargingStationCard extends StatelessWidget {
  final ChargingStation station;
  final VoidCallback onToggleSave;
  final VoidCallback onView;
  final VoidCallback onBook;

  const _ChargingStationCard({
    required this.station,
    required this.onToggleSave,
    required this.onView,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenUtil().screenHeight;
    final screenWidth = ScreenUtil().screenWidth;
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.greyScale50,
        border: Border.all(color: AppColor.greyScale200),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Station Name and Navigation Button
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      station.name,
                      style: TextStyle(
                        fontFamily: Constants.urbanistFont,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.greyScale900,
                      ),
                    ),
                    // Address
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      station.address,
                      style: TextStyle(
                        fontFamily: Constants.urbanistFont,
                        fontSize: 14.sp,
                        color: AppColor.greyScale700,
                      ),
                    ),
                  ],
                ),
              ),

              Spacer(),

              // route navigator 
              GestureDetector(
                onTap: () {
                  
                }, child: RouteNavigator()),
            ],
          ),
          SizedBox(height: 8.h),

          SizedBox(height: 12.h),

          // Rating and Reviews
          RatingStar(rating: '4.2', ratingCount: '120'),
          SizedBox(height: 12.h),

          // Status, Distance, and Travel Time
          StationData(stationDistanceInKm: '1.6', stationDuration: '5min', stationStatus: 'Available'),
          SizedBox(height: 12.h),
          Divider(thickness: 0.5,), 

          // Charger Types
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Expanded(
              //   child: Wrap(
              //     spacing: 8.w,
              //     children:
              //         station.chargerTypes.map((type) {
              //           return Container(
              //             width: 40.w,
              //             height: 40.h,
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(8.r),
              //             ),
              //             child: Icon(
              //               Icons.ev_station,
              //               size: 20.sp,
              //               color: Colors.black,
              //             ),
              //           );
              //         }).toList(),
              //   ),
              // ),
              TextButton(
                onPressed: () {
                  // Show all chargers
                },
                child: Row(
                  children: [
                    Text(
                      '${station.chargersCount} chargers',
                      style: TextStyle(
                        fontFamily: Constants.urbanistFont,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00C853),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right,
                      size: 16.sp,
                      color: AppColor.primary_900,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(thickness: 0.5,), 

          SizedBox(height: 7.h),

          // Action Buttons
          Row(
            spacing: 10.w,
            children: [
              Expanded(
                child: CustomButton(
                  title: "View",
                  buttonColor: AppColor.white,
                  borderRadius: 30.r,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  textColor: AppColor.primary_900,
                  border: Border.all(color: AppColor.primary_900 , width: 2),
                  )
              ),
              
              Expanded(
                child: CustomButton(
                  borderRadius: 30.r,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  textColor: AppColor.white,
                  buttonColor: AppColor.primary_900,
                  title: "Book")
              ),
            ],
          ),
        ],
      ),
    );
  }
}
