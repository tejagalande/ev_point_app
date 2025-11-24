import 'package:ev_point/routes/app_routes.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          children: [
            _buildProfileSection(),
            SizedBox(height: 24.h),
            Divider(color: AppColor.greyScale200, thickness: 1),
            SizedBox(height: 24.h),
            _buildMenuOptions(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsets.all(10.r),
        child: SvgPicture.asset(
          "${Constants.iconPath}logo_evPoint.svg",
          errorBuilder:
              (context, error, stackTrace) =>
                  Icon(Icons.electric_bolt, color: AppColor.primary_500),
        ),
      ),
      leadingWidth: 56.w,
      title: Text(
        "Account",
        style: TextStyles.h4Bold24.copyWith(color: AppColor.greyScale900),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_horiz_rounded,
            color: AppColor.greyScale900,
            size: 28,
          ),
        ),
        SizedBox(width: 12.w),
      ],
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundImage: AssetImage(
            "${Constants.imagePath}avatar.png",
          ), // Assuming avatar exists, fallback handled if not
          // backgroundColor: AppColor.greyScale200,
          onBackgroundImageError: (_, __) {},
          child: Image.asset(
            "${Constants.imagePath}avatar.png",
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) =>
                    Icon(Icons.person, color: AppColor.greyScale500),
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Andrew Ainsley",
                style: TextStyles.h5Bold20.copyWith(
                  color: AppColor.greyScale900,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "+1 111 467 378 399",
                style: TextStyles.bodyMediumMedium14.copyWith(
                  color: AppColor.greyScale700,
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.arrow_forward_ios, size: 16, color: AppColor.greyScale900),
      ],
    );
  }

  Widget _buildMenuOptions() {
    return Column(
      children: [
        _buildMenuItem(
          icon: "my_vehicle_menu.svg",
          title: "My Vehicle",
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.myVehicleRoute);
          },
        ),
        _buildMenuItem(
          icon: "card_menu.svg",
          title: "Payment Methods",
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.myPaymentMethodsRoute);
          },
        ),
        SizedBox(height: 12.h),
        Divider(color: AppColor.greyScale200, thickness: 1),
        SizedBox(height: 12.h),
        _buildMenuItem(
          icon: "profile_menu.svg",
          title: "Personal Info",
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.userProfileRoute);
          },
        ),
        _buildMenuItem(
          icon: "security_menu.svg",
          title: "Security",
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.securityRoute);
          },
        ),
        _buildMenuItem(
          icon:
              "document_menu.svg", // Using document as placeholder for Language if specific not found, or Icons.language
          title: "Language",
          trailing: Row(
            children: [
              Text(
                "English (US)",
                style: TextStyles.bodyLargeSemiBold16.copyWith(
                  color: AppColor.greyScale900,
                ),
              ),
              SizedBox(width: 12.w),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColor.greyScale900,
              ),
            ],
          ),
          onTap: () {},
          isSvg: true,
        ),
        _buildMenuItem(
          icon: "dark_mode_menu.svg",
          title: "Dark Mode",
          trailing: Switch(
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
            },
            activeColor: AppColor.white,
            activeTrackColor: AppColor.primary_500,
            inactiveThumbColor: AppColor.white,
            inactiveTrackColor: AppColor.greyScale200,
          ),
          onTap: () {},
        ),
        SizedBox(height: 12.h),
        Divider(color: AppColor.greyScale200, thickness: 1),
        SizedBox(height: 12.h),
        _buildMenuItem(
          icon: "help_center_menu.svg",
          title: "Help Center",
          onTap: () {},
        ),
        _buildMenuItem(
          icon: "privacy_policy_menu.svg",
          title: "Privacy Policy",
          onTap: () {},
        ),
        _buildMenuItem(
          icon: "about_menu.svg",
          title: "About EVPoint",
          onTap: () {},
        ),
        _buildMenuItem(
          icon: "logout_menu.svg",
          title: "Logout",
          textColor: AppColor.red,
          onTap: () {},
          hideArrow: true,
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
    Color? textColor,
    bool hideArrow = false,
    bool isSvg = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          spacing: 15.w,
          children: [
            isSvg
                ? SvgPicture.asset(
                  "${Constants.iconPath}$icon",
                  height: 24.h,
                  width: 24.w,
                  color: textColor ?? AppColor.greyScale900,
                  // colorFilter: ColorFilter.mode(textColor ?? AppColor.greyScale900, BlendMode.srcIn),
                )
                : Icon(Icons.error, color: AppColor.greyScale900), // Fallback

            Expanded(
              child: Text(
                title,
                style: TextStyles.h6Bold18.copyWith(
                  color: textColor ?? AppColor.greyScale900,
                ),
              ),
            ),
            if (trailing != null)
              trailing
            else if (!hideArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColor.greyScale900,
              ),
          ],
        ),
      ),
    );
  }
}
