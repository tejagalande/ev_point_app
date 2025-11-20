import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StationData extends StatelessWidget {
  final String stationStatus;
  final String stationDistanceInKm;
  final String stationDuration;
  const StationData({
    super.key,
    required this.stationDistanceInKm,
    required this.stationDuration,
    required this.stationStatus
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.primary_900,
            borderRadius: BorderRadius.circular(6.r)
          ),
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Text(stationStatus ?? "" , style: TextStyle(color: AppColor.white, fontSize: 10.sp , fontFamily: Constants.urbanistFont, fontWeight: FontWeight.w600 ),),
        ),
    
        Row(
          spacing: 3.w,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on_rounded),
            Text(stationDistanceInKm ?? "" , style: TextStyle(color: AppColor.greyScale700, fontSize: 10.sp , fontFamily: Constants.urbanistFont, fontWeight: FontWeight.w600 ),)
          ],
        ),
    
        Row(
          spacing: 3.w,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.directions_car),
            Text(stationDuration ?? "" , style: TextStyle(color: AppColor.greyScale700, fontSize: 10.sp , fontFamily: Constants.urbanistFont, fontWeight: FontWeight.w600 ),)
          ],
        ),
      ],
    );
  }
}
