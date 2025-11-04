import 'dart:developer';

import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChargerTab extends StatefulWidget {
  const ChargerTab({
    super.key,
  });

  @override
  State<ChargerTab> createState() => _ChargerTabState();
}

class _ChargerTabState extends State<ChargerTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body:  ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: AppColor.primary_900, width: 4.w),),
            color: AppColor.greyScale50,
            borderRadius: BorderRadius.circular(15).r
          ),
          child: Padding(
            padding:  EdgeInsets.all(16).r ,
            child: Column(
              //  mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("24 hours"),
                    Row(
                      spacing: 10.w,
                      children: [
                        Text("Available"),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.primary_900
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                Divider(thickness: 0.5,),

                LayoutBuilder(
                  builder: (context, constraints) {
                    log("Row width: ${constraints.maxWidth / 2.5 } ");
                    return Row(
                  spacing: 10.w,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth / 2.5,
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            "Tesla (plug) . AC/DC", style: TextStyle(fontFamily: Constants.urbanistFont, color: AppColor.greyScale700, fontSize: 16.sp),)),
                        Icon(Icons.power_off)
                      ],
                    ),
                
                    SizedBox(
                      height: 30,
                      child: VerticalDivider(thickness: 2,)),
                
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Max power", style: TextStyle(fontFamily: Constants.urbanistFont, color: AppColor.greyScale700, fontSize: 16.sp),),
                        Text("100 kw", style: TextStyle(fontFamily: Constants.urbanistFont, color: AppColor.greyScale900, fontWeight: FontWeight.bold ,fontSize: 32.sp),)
                      ],
                    ),
                  ],
                );
                  },
                ),

                 Divider(thickness: 0.5,),


                CustomButton(title: "Book",

                buttonColor: AppColor.primary_900,
                textColor: AppColor.white,
                borderRadius: 25.r,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                onTapCallback: () {
                  
                },
                )
              ],
            ),
          ),
        );
      },
    ),
    );
  }
}
