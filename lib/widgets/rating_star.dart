import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingStar extends StatelessWidget {
  final String rating;
  final String ratingCount;

  const RatingStar({
    super.key,
    required this.rating,
    required this.ratingCount
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.w,
      children: [
        Text(rating ?? "", style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 14.sp,fontWeight: FontWeight.w600 ,color: AppColor.greyScale700),),
        RatingBar.readOnly(
          filledIcon: Icons.star_rounded,
          filledColor: AppColor.primary_900,
          halfFilledColor: AppColor.primary_900,
          isHalfAllowed: true,
          size: 25,
          halfFilledIcon: Icons.star_half_rounded,
          emptyIcon: Icons.star_border_rounded,
          initialRating: double.parse(rating ?? '0.0'),
          maxRating: 5,
        ),
        Text("(${ratingCount} reviews)", style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 14.sp,fontWeight: FontWeight.w500 ,color: AppColor.greyScale600),)
      ],
    );
  }
}
