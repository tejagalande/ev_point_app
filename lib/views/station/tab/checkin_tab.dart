import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CheckinTab extends StatefulWidget {
  const CheckinTab({super.key});

  @override
  State<CheckinTab> createState() => _CheckinTabState();
}

class _CheckinTabState extends State<CheckinTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Divider(thickness: 0.5,),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
            child: CustomButton(
              title: "Check-in",
              boldText: true,
              isShadow: true,
              buttonColor: AppColor.primary_900,
              textColor: AppColor.white,
              borderRadius: 30.r,
              onTapCallback: () {
                
              },
              ),
          )
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(thickness: 0.5,),
        padding: const EdgeInsets.all(20),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.h,
            children: [
              Row(
                spacing: 5.w,
                children: [
                  SvgPicture.asset("${Constants.iconPath}charge_success.svg", height: 35,),
                  Container(
                    height: 50,
                    width: 50, 
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      shape: BoxShape.circle,
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5.h,
                    children: [
                      Text("Jenny Wilson", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: Constants.urbanistFont, color: AppColor.greyScale900 )),
                      Text("Tesla Model 3", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500,color: AppColor.greyScale700 ,fontFamily: Constants.urbanistFont)),
                    ],
                  ),

                  Spacer(),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 5.h,
                    children: [
                      Text("12-28-2025", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500,color: AppColor.greyScale700 ,fontFamily: Constants.urbanistFont)),
                      Text("15:30 PM", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500,color: AppColor.greyScale700 ,fontFamily: Constants.urbanistFont)),
                    ],
                  ),
                ],
              ),

              // comment 
              Text("This place is very nice and comfortable. This place is very nice and comfortable",  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500,color: AppColor.greyScale900 ,fontFamily: Constants.urbanistFont)),
            ],
          );
        },
      ),
    );
  }
}
