import 'package:ev_point/controllers/account/security_controller.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:ev_point/widgets/back_arrow.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SecurityController(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: _buildAppBar(context),
        body: Consumer<SecurityController>(
          builder: (context, controller, child) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSwitchTile(
                    title: "Remember me",
                    value: controller.rememberMe,
                    onChanged: controller.toggleRememberMe,
                  ),
                  _buildSwitchTile(
                    title: "Biometric ID",
                    value: controller.biometricId,
                    onChanged: controller.toggleBiometricId,
                  ),
                  _buildSwitchTile(
                    title: "Face ID",
                    value: controller.faceId,
                    onChanged: controller.toggleFaceId,
                  ),
                  _buildSwitchTile(
                    title: "SMS Authenticator",
                    value: controller.smsAuthenticator,
                    onChanged: controller.toggleSmsAuthenticator,
                  ),
                  _buildSwitchTile(
                    title: "Google Authenticator",
                    value: controller.googleAuthenticator,
                    onChanged: controller.toggleGoogleAuthenticator,
                  ),
                  SizedBox(height: 10.h),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Device Management",
                      style: TextStyles.h5Bold20.copyWith(
                        color: AppColor.greyScale900,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20.r,
                      color: AppColor.greyScale900,
                    ),
                    onTap: () {
                      // Navigate to Device Management
                    },
                  ),
                  SizedBox(height: 40.h),
                  CustomButton(
                    onTapCallback: () {
                      // Handle Change Password
                    },
                    title: "Change Password",
                    buttonColor: AppColor.primary_100,
                    textColor: AppColor.primary_900,
                    borderRadius: 35.r,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: backArrow(),
      ),
      title: Text(
        "Security",
        style: TextStyles.h4Bold24.copyWith(color: AppColor.greyScale900),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.h5Bold20.copyWith(color: AppColor.greyScale900),
          ),
          Switch( 
            value: value,
            onChanged: onChanged,
            activeColor: AppColor.white,
            activeTrackColor: AppColor.primary_900,
            inactiveThumbColor: AppColor.white,
            inactiveTrackColor: AppColor.greyScale200,
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ],
      ),
    );
  }
}
