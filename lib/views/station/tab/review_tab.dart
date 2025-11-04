import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewTab extends StatefulWidget {
  const ReviewTab({
    super.key,
  });

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
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
              title: "Write a Review",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w, vertical: 5.h),
              child: Row(
                spacing: 10.w,
                children: [
              
                  // rating text and rating stars icon
                  Column(
                    spacing: 10.h,
                    children: [
                      Text("4.5", style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold, fontFamily: Constants.urbanistFont, color: AppColor.greyScale900 ),),
                       RatingBar.readOnly(
                                  filledIcon: Icons.star_rounded,
                                  filledColor: AppColor.primary_900,
                                  halfFilledColor: AppColor.primary_900,
                                  isHalfAllowed: true,
                                  size: 25,
                                  halfFilledIcon: Icons.star_half_rounded,
                                  emptyIcon: Icons.star_border_rounded,
                                  initialRating: double.parse('4.5'),
                                  maxRating: 5,
                                ),
                                Text("(128 reviews)", style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 18.sp,fontWeight: FontWeight.w600 ,color: AppColor.greyScale800),)
                    ],
                  ),
              
                  SizedBox(
                    height: 120.h,
                    child: VerticalDivider(
                      thickness: 0.5,
                    ),
                  ),
              
                  // linear progress bar 
                  Expanded(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        rateCount("5", 0.9),
                        rateCount("4", 0.8),
                        rateCount("3", 0.7),
                        rateCount("2", 0.5), 
                        rateCount("1", 0.3), 
                      ]
                    ),
                  )
                      
                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.w),
              child: Divider(),
            ),
        
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sort by", style: TextStyle( fontFamily: Constants.urbanistFont , fontSize: 20.sp, fontWeight: FontWeight.bold ),),
                  Text("Newest", style: TextStyle( color: AppColor.primary_900, fontFamily: Constants.urbanistFont , fontSize: 16.sp, fontWeight: FontWeight.bold ), )
                ],
              ),
            ),
        
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Divider(thickness: 0.5,),
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.w),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(16).r ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.green.shade100,
                      child: Text(
                        'R${index + 1}',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reviewer ${index + 1}',
                            style:  TextStyle(
                              fontSize: 18.sp,
                              fontFamily: Constants.urbanistFont,
                              color: AppColor.greyScale900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                         Text(
                            '12-28-2025',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: Constants.urbanistFont,
                              color: AppColor.greyScale700,
                            ),
                          ),
                         Text(
                            '16:22',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: Constants.urbanistFont,
                              color: AppColor.greyScale700,
                            ),
                          ),
                      ]
                      
                 
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  'Great charging station! Clean facilities and fast charging speeds. Would definitely recommend to other EV owners.',
                  style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: Constants.urbanistFont,
                              color: AppColor.greyScale900,
                              
                            ),
                ),
              ],
            ),
          );
        },
            ),
          ],
        ),
      )
    );
  }

  Widget rateCount(String index, double count) {
    return Row(
      
                        spacing: 10.w,
                        children: [
                          Text( 
                            
                            index , style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 16.sp,fontWeight: FontWeight.w600 ,color: AppColor.greyScale900), ),
                          Expanded(
                            child: LinearProgressIndicator( 
                              value: count,
                              borderRadius: BorderRadius.circular(15).r,
                              minHeight: 5,
                              color: AppColor.primary_900,
                            ),
                          ),
                          
                        ],
                      );
  }
}
