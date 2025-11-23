import 'package:ev_point/routes/app_routes.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyPaymentMethodsScreen extends StatefulWidget {
  const MyPaymentMethodsScreen({super.key});

  @override
  State<MyPaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<MyPaymentMethodsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              children: [
                _buildPaymentMethodItem(
                  icon: Icons.paypal, // Placeholder for PayPal
                  iconColor: Colors.blue,
                  title: "PayPal",
                  isConnected: true,
                  isImage: false,
                ),
                SizedBox(height: 24.h),
                _buildPaymentMethodItem(
                  imagePath: "${Constants.imagePath}google_icon.png",
                  title: "Google Pay",
                  isConnected: true,
                  isImage: true,
                ),
                SizedBox(height: 24.h),
                _buildPaymentMethodItem(
                  imagePath: "${Constants.imagePath}apple_icon.png",
                  title: "Apple Pay",
                  isConnected: true,
                  isImage: true,
                ),
                SizedBox(height: 24.h),
                _buildPaymentMethodItem(
                  icon: Icons.credit_card, // Placeholder for Visa
                  iconColor: Colors.blue[900],
                  title: ".... .... .... 5567",
                  isConnected: true,
                  isImage: false,
                  isVisa: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.r),
            child: SizedBox(
              width: double.infinity,
              height: 58.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.addNewPaymentRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary_50,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: AppColor.primary_500),
                    SizedBox(width: 8.w),
                    Text(
                      "Add New Payment",
                      style: TextStyles.bodyLargeBold16.copyWith(
                        color: AppColor.primary_500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back, color: AppColor.greyScale900),
      ),
      title: Text(
        "Payment Methods",
        style: TextStyles.h4Bold24.copyWith(color: AppColor.greyScale900),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "${Constants.iconPath}scan_black_icon.svg",
            color: AppColor.greyScale900,
          ),
        ),
        SizedBox(width: 12.w),
      ],
    );
  }

  Widget _buildPaymentMethodItem({
    String? imagePath,
    IconData? icon,
    Color? iconColor,
    required String title,
    required bool isConnected,
    required bool isImage,
    bool isVisa = false,
  }) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColor.greyScale50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.greyScale200),
  
      ),
      child: Row(
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            alignment: Alignment.center,
            child:
                isImage
                    ? Image.asset(imagePath!, height: 32.h)
                    : isVisa
                    ? Container(
                      height: 32.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                        color: iconColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          "VISA",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    )
                    : Icon(icon, size: 32, color: iconColor),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: TextStyles.h6Bold18.copyWith(color: AppColor.greyScale900),
            ),
          ),
          if (isConnected)
            Text(
              "Connected",
              style: TextStyles.bodyLargeBold16.copyWith(
                color: AppColor.primary_500,
              ),
            ),
        ],
      ),
    );
  }
}
