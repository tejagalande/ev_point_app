import 'package:ev_point/controllers/station/station_detail_provider.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class InfoTab extends StatefulWidget {
  const InfoTab({super.key});

  @override
  State<InfoTab> createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // About Section
                    Text(
                      'About',
                      style: TextStyle(
                        fontFamily: Constants.urbanistFont,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // about text
                    ReadMoreText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labor et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: Constants.urbanistFont,
                        color: AppColor.black,
                        height: 1.5,
                      ),
                      trimMode: TrimMode.Line,
                      trimLines: 3,
                      trimCollapsedText: "Read more...",
                      moreStyle: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: Constants.urbanistFont,
                        color: AppColor.primary_900,
                        height: 1.5,
                      ),
                      trimExpandedText: " Show less",
                      lessStyle: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: Constants.urbanistFont,
                        color: AppColor.primary_900,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Parking and Payment Info
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColor.greyScale50,
                        border: Border.all(color: AppColor.greyScale200),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Parking',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor.greyScale700,
                                  fontFamily: Constants.urbanistFont,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Cost',
                                style: TextStyle(
                                  fontFamily: Constants.urbanistFont,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          Divider(thickness: 0.5),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pay',
                                style: TextStyle(
                                  color: AppColor.greyScale700,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Constants.urbanistFont,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Payment is required',
                                style: TextStyle(
                                  fontFamily: Constants.urbanistFont,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Operating Hours
                    // GestureDetector(
                    //   onTap: () {

                    //     setState(() {
                    //       _isHoursExpanded = !_isHoursExpanded;
                    //     });
                    //   },
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Icon(
                    //             Icons.access_time,
                    //             color: Colors.green,
                    //             size: 20,
                    //           ),
                    //           const SizedBox(width: 8),
                    //           const Text(
                    //             'Open',
                    //             style: TextStyle(
                    //               color: Colors.green,
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //           const SizedBox(width: 8),
                    //           const Text(
                    //             '24 hours',
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       Icon(
                    //         _isHoursExpanded
                    //             ? Icons.keyboard_arrow_up
                    //             : Icons.keyboard_arrow_down,
                    //         color: Colors.grey,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Selector<StationDetailProvider , bool>(
                      selector: (p0, p1) => p1.isExpanded,
                      builder: (context, value, child) {
                        return Container(
                      decoration: BoxDecoration(
                        color: AppColor.greyScale50,
                        border: Border.all(color: AppColor.greyScale200),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        childrenPadding: EdgeInsets.symmetric(horizontal: 15.w),
                        title: RichText(
                          text: TextSpan(
                            text: "Open",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              fontFamily: Constants.urbanistFont,
                              color: AppColor.primary_900,
                            ),
                            children: [
                              TextSpan(
                                text: "  24 hours",
                                style: TextStyle(
                                  fontFamily: Constants.urbanistFont,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                  color: AppColor.greyScale700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        leading: Icon(
                          Icons.access_time,
                          color: AppColor.black,
                        ),
                        
                        trailing: Icon(
                          value
                              ? Icons.keyboard_arrow_up_outlined
                              : Icons.keyboard_arrow_down_outlined,
                        ),
                        shape: Border(),
                        onExpansionChanged: (_) {

                          context.read<StationDetailProvider>().expandTile();
                        },
                        dense: true,
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        children: [
                          _buildHoursRow('Monday', '00:00 - 00:00'),
                          _buildHoursRow('Tuesday', '00:00 - 00:00'),
                          _buildHoursRow('Wednesday', '00:00 - 00:00'),
                          _buildHoursRow('Thursday', '00:00 - 00:00'),
                          _buildHoursRow('Friday', '00:00 - 00:00'),
                          _buildHoursRow('Saturday', '00:00 - 00:00'),
                          _buildHoursRow('Sunday', '00:00 - 00:00'),
                        ],
                      ),
                    );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Amenities Section
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                      decoration: BoxDecoration(
                               color: AppColor.greyScale50,
                        border: Border.all(color: AppColor.greyScale200),
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            'Amenities',
                            style: TextStyle(
                              fontSize: 18.sp,

                              fontFamily: Constants.urbanistFont,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Divider(thickness: 0.5,),
                          
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 3.5,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            children: [
                              _buildAmenityItem("restroom_icon.svg", 'Restrooms'),
                              _buildAmenityItem("loung_icon.svg", 'Lounge area'),
                              _buildAmenityItem("restaurant_icon.svg", 'Restaurant'),
                              _buildAmenityItem("wifi_icon.svg", 'Wi-Fi'),
                              _buildAmenityItem("entertainment_icon.svg", 'Entertainment'),
                              _buildAmenityItem("air_for_tyer_icon.svg", 'Air for Tyres'),
                              _buildAmenityItem("shops_icon.svg", 'Shops'),
                              _buildAmenityItem("maintenance_icon.svg", 'Maintenance'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Location Section
                    Text(
                      'Location',
                      style: TextStyle(
                        fontFamily: Constants.urbanistFont,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: AppColor.primary_900, size: 20),
                        const SizedBox(width: 8),
                         Text(
                           'Brooklyn, 589 Prospect Avenue',
                           style: TextStyle(fontSize: 16.sp, color: AppColor.greyScale600),
                         ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(color: Colors.grey.shade300),
                            Icon(
                              Icons.ev_station,
                              size: 60,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
    );
  }
}



Widget _buildHoursRow(String day, String hours) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(day, style:  TextStyle(fontSize: 18.sp, fontFamily: Constants.urbanistFont, fontWeight: FontWeight.w600)),
        Text(hours, style:  TextStyle(fontSize: 18.sp  , fontFamily: Constants.urbanistFont, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

Widget _buildAmenityItem(String icon, String label) {
  return Container(
    padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        SvgPicture.asset("${Constants.iconPath}$icon"),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style:  TextStyle(fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}