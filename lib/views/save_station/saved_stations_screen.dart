// saved_stations_screen.dart
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../controllers/save_station/saved_stations_provider.dart';
import '../../utils/constants.dart';



class SavedStationsScreen extends StatelessWidget {
  const SavedStationsScreen({Key? key}) : super(key: key);

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
          child: SvgPicture.asset("${Constants.iconPath}logo_evPoint.svg",),
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
            onTap: () {
              
            },
            child: SvgPicture.asset("${Constants.iconPath}search.svg", color: AppColor.greyScale900, height: 30,))
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
            padding: EdgeInsets.all(16.w),
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
      bottomNavigationBar: const _BottomNavBar(),
    )
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  station.name,
                  style: TextStyle(
                    fontFamily: Constants.urbanistFont,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.greyScale900,
                  ),
                ),
              ),
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF00C853),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.navigation,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  onPressed: () {
                    // Open navigation/maps
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          
          // Address
          Text(
            station.address,
            style: TextStyle(
              fontFamily: Constants.urbanistFont,
              fontSize: 14.sp,
              color: AppColor.greyScale700,
            ),
          ),
          SizedBox(height: 12.h),
          
          // Rating and Reviews
          Row(
            children: [
              Text(
                station.rating.toString(),
                style: TextStyle(
                  fontFamily: Constants.urbanistFont,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 4.w),
              ...List.generate(
                5,
                (index) => Icon(
                  index < station.rating.floor()
                      ? Icons.star
                      : (index < station.rating ? Icons.star_half : Icons.star_border),
                  color: const Color(0xFFFFA726),
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '(${station.reviewsCount} reviews)',
                style: TextStyle(
                  fontFamily: Constants.urbanistFont,
                  fontSize: 13.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          
          // Status, Distance, and Travel Time
          Row(
            children: [
              // Status Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: station.isAvailable
                      ? const Color(0xFF00C853)
                      : const Color(0xFFEF5350),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  station.isAvailable ? 'Available' : 'In Use',
                  style: TextStyle(
                    fontFamily: Constants.urbanistFont,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              
              // Distance
              Icon(Icons.location_on, size: 16.sp, color: Colors.grey[600]),
              SizedBox(width: 4.w),
              Text(
                '${station.distance} km',
                style: TextStyle(
                  fontFamily: Constants.urbanistFont,
                  fontSize: 13.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(width: 12.w),
              
              // Travel Time
              Icon(Icons.directions_car, size: 16.sp, color: Colors.grey[600]),
              SizedBox(width: 4.w),
              Text(
                '${station.travelTime} mins',
                style: TextStyle(
                  fontFamily: Constants.urbanistFont,
                  fontSize: 13.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          
          // Charger Types
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8.w,
                  children: station.chargerTypes.map((type) {
                    return Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.ev_station,
                        size: 20.sp,
                        color: Colors.black,
                      ),
                    );
                  }).toList(),
                ),
              ),
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
                      color: const Color(0xFF00C853),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onView,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    side: const BorderSide(
                      color: Color(0xFF00C853),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'View',
                    style: TextStyle(
                      fontFamily: Constants.urbanistFont,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00C853),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: onBook,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C853),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Book',
                    style: TextStyle(
                      fontFamily: Constants.urbanistFont,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBarItem(
                icon: Icons.home_outlined,
                label: 'Home',
                isActive: false,
                onTap: () {},
              ),
              _NavBarItem(
                icon: Icons.bookmark_border,
                label: 'Saved',
                isActive: true,
                onTap: () {},
              ),
              _NavBarItem(
                icon: Icons.check_circle_outline,
                label: 'My Booking',
                isActive: false,
                onTap: () {},
              ),
              _NavBarItem(
                icon: Icons.account_balance_wallet_outlined,
                label: 'My Wallet',
                isActive: false,
                onTap: () {},
              ),
              _NavBarItem(
                icon: Icons.person_outline,
                label: 'Account',
                isActive: false,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF00C853) : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey[400],
              size: 24.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: Constants.urbanistFont,
              fontSize: 11.sp,
              color: isActive ? const Color(0xFF00C853) : Colors.grey[600],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
