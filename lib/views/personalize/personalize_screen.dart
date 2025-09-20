import 'package:ev_point/routes/app_routes.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalizeScreen extends StatelessWidget {
  const PersonalizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        // title: Text("Set Vehicle"),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(thickness: 0.5,),
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
            child: Row(
              spacing: 30.w,
              children: [
                Expanded(
                  child: CustomButton(
                    title: "Add Later",
                    blurRadius: 20,
                    boxShadowColor: AppColor.greyScale50,
                    buttonColor: AppColor.primary_50,
                    borderRadius: 25.r,
                    isShadow: true,
                    textColor: AppColor.primary_900,
                    onTapCallback: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context, 
                        AppRoutes.mainRoute, (Route<dynamic> route) => false  );
                    },
                    ),
                ),
            
                  Expanded(
                    child: CustomButton(
                    title: "Add Vehicle",
                    buttonColor: AppColor.primary_900,
                    blurRadius: 20,
                    isShadow: true,
                    boxShadowColor: AppColor.greyScale300,
                    borderRadius: 25.r,
                    textColor: AppColor.primary_50,
                    onTapCallback: () {
                      
                    },
                    ),
                  ),
              ],
            ),
          )
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          spacing: 15.h,
          children: [
            Text("Personalize your experience by adding a vehicle 🚘",
            style: TextStyles.h3Bold32,),
            Text("Your vehicle is used to determine compatible charging stations.", style: TextStyles.bodyXlargeRegular18,),

            SizedBox(height: 30.h,),
            Image.asset(
              // height: ScreenUtil().scaleHeight * .5,
              height: 200.h,
              "${Constants.imagePath}personalize_image.png"
              )
          ],
        ),
      )
    );
  }
}