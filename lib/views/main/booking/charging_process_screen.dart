import 'package:ev_point/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/charging_process_provider.dart';
import '../../../utils/theme/app_color.dart';
import '../../../widgets/custom_button.dart';


class ChargingProcessScreen extends StatelessWidget {
  const ChargingProcessScreen({Key? key}) : super(key: key);

  String _formatDuration(Duration d) {
    final twoDigits = (int n) => n.toString().padLeft(2, '0');
    final h = twoDigits(d.inHours);
    final m = twoDigits(d.inMinutes.remainder(60));
    final s = twoDigits(d.inSeconds.remainder(60));
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChargingProcessProvider(),
      child: Consumer<ChargingProcessProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColor.white, // example
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColor.white,
              leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColor.greyScale900,
                  size: 24.sp,
                ),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              centerTitle: false,
              title: Text(
                'Charging',
                style: TextStyle(
                  color: AppColor.greyScale900,
                  fontSize: 24.sp,
                  fontFamily: Constants.urbanistFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // actions: [
              //   IconButton(
              //     icon: Icon(
              //       Icons.more_horiz,
              //       color: AppColor.greyScale800,
              //       size: 24.sp,
              //     ),
              //     onPressed: () {},
              //   ),
              // ],
              surfaceTintColor: Colors.transparent,
            ),
            bottomNavigationBar:  // Stop button
                  Column( 
                    mainAxisSize: MainAxisSize.min,
                    // spacing: 1.h,
                    children: [
                      Divider(thickness: 0.5,),
                      CustomButton(
                        margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                        title: 'Stop Charging',
                        // padding: EdgeInsets.zero,
                        buttonColor: AppColor.primary_900,
                        textColor: AppColor.white,
                        borderRadius: 30.r,
                        isShadow: true,
                        boldText: true,
                        onTapCallback: () {
                          provider.stopCharging();
                        },
                      ),
                    ],
                  ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 32.h),
              
                    // Energy circular card
                    InkWell(
                      onTap:()=> provider.chargingComplete(context),
                      child: Container(
                        width: 230.w, 
                        height: 230.w,
                        
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.primary_900.withAlpha(100),
                              blurRadius: 30.r,
                              spreadRadius: 2.r,
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 230.w,
                              height: 230.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColor.primary_900,
                                  width: 3.w,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 12.h),
                                SvgPicture.asset("${Constants.iconPath}flash_icon.svg"),
                                
                                // charging power digit and unit
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      provider.energyKwh.toStringAsFixed(0),
                                      style: TextStyle(
                                        fontSize: 70.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Constants.urbanistFont,
                                        color: AppColor.greyScale900,
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 6.h),
                                      child: Text(
                                        'kWh',
                                        style: TextStyle(
                                          fontFamily: Constants.urbanistFont,
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.greyScale800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                
                      
                                // energy text
                                Text(
                                  'Energy',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: Constants.urbanistFont,
                                    color: AppColor.greyScale600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              
                    SizedBox(height: 40.h),
              
                    // Info card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 24.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.greyScale50,
                        border: Border.all( color: AppColor.greyScale200 ),
                        borderRadius: BorderRadius.circular(20.r),
                        
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _InfoTile(
                                  title: _formatDuration(provider.chargingTime),
                                  subtitle: 'Charging Time',
                                ),
                              ),
                              Container(
                                width: 1.w,
                                height: 40.h,
                                color: AppColor.greyScale200,
                              ),
                              Expanded(
                                child: _InfoTile(
                                  title: '${provider.batteryPercent}%',
                                  subtitle: 'Battery',
                                  alignEnd: true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          Divider(
              
                            thickness: 0.5,
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            children: [
                              Expanded(
                                child: _InfoTile(
                                  title:
                                      provider.currentAmp.toStringAsFixed(2) + ' Amp',
                                  subtitle: 'Current',
                                ),
                              ),
                              Container(
                                width: 1.w,
                                height: 40.h,
                                color: AppColor.greyScale200,
                              ),
                              Expanded(
                                child: _InfoTile(
                                  title: '\$${provider.totalFees.toStringAsFixed(2)}',
                                  subtitle: 'Total Fees',
                                  alignEnd: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              
                    
              
                   
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool alignEnd;

  const _InfoTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.alignEnd = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final alignment = alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.center;
    final alignment = CrossAxisAlignment.center;
    return Column(
      crossAxisAlignment: alignment,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            fontFamily: Constants.urbanistFont,
            color: AppColor.greyScale900,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: Constants.urbanistFont,
            fontWeight: FontWeight.w500,
            color: AppColor.greyScale700,
          ),
        ),
      ],
    );
  }
}
