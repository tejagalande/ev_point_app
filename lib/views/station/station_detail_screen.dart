import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ev_point/controllers/station/station_detail_provider.dart';
import 'package:ev_point/routes/app_routes.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StationDetailScreen extends StatefulWidget {
  const StationDetailScreen({super.key});

  @override
  State<StationDetailScreen> createState() => _StationDetailScreenState();
}

class _StationDetailScreenState extends State<StationDetailScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;


  @override
  void initState() {
     
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = ScreenUtil().screenWidth;
    final screenHeight = ScreenUtil().screenHeight;
    bool _isHoursExpanded = true;
    return ChangeNotifierProvider(
      create: (context) => StationDetailProvider(),
      child: Scaffold(
        backgroundColor: AppColor.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            // Expandable App Bar with Image
            SliverAppBar(
              expandedHeight: 250.0,
              pinned: true,
              floating: false,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.white,
              // elevation: 15,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.black),
                  onPressed: () {},
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://images.unsplash.com/photo-1593941707882-a5bba14938c7?w=800',
                  fit: BoxFit.cover,
                ),
                // title: Text("Walgreen"),
                
              ),
            ),
            // Station Details Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Location
                    const Text(
                      'Walgreens - Brooklyn, NY',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Brooklyn, 589 Prospect Avenue',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Rating
                    Row(
                      children: [
                        const Text(
                          '4.5',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        RatingBar.readOnly(
                                filledIcon: Icons.star_rounded,
                                filledColor: AppColor.primary_900,
                                halfFilledColor: AppColor.primary_900,
                                isHalfAllowed: true,
                                size: 25,
                                halfFilledIcon: Icons.star_half_rounded,
                                emptyIcon: Icons.star_border_rounded,
                                initialRating: double.parse( '4.5'),
                                maxRating: 5,
                              ),
                              Text("(130 reviews)", style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 14.sp,fontWeight: FontWeight.w500 ,color: AppColor.greyScale600),)
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Status and Info Row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: const Text(
                            'Available',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),


                        Icon(Icons.location_on_rounded),
                        const SizedBox(width: 4),
                        const Text(
                          '1.6 km',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),

                        const SizedBox(width: 16),
                        Icon(Icons.directions_car),

                        Divider(),
                        const SizedBox(width: 4),
                        const Text(
                          '5 mins',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Divider(thickness: 0.5,),

                    // Action Buttons
                    Row(
                            spacing: 20.w,
                            children: [

                              // view button
                              Expanded(
                                child: CustomButton(
                                  title: "View",
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  buttonColor: AppColor.white,
                                  border: Border.all(color: AppColor.primary_900, width: 2.w),
                                  borderRadius: 30.r,
                                  textColor: AppColor.primary_900,
                                  onTapCallback: () {
                                    Navigator.pushNamed(context, AppRoutes.stationDetailRoute);
                                  },

                                  ),
                              ),

                              // book button
                              Expanded(
                                child: CustomButton(
                                  title: "Book",
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  buttonColor: AppColor.primary_900,
                                  textColor: AppColor.white,
                                  borderRadius: 30.r,
                                  onTapCallback: () {

                                  },

                                  ),
                              ),
                            ],
                          ),
                          Divider(thickness: 0.5,),
                    // const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            // Tab Bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyTabBarDelegate(
                TabBar(
                  controller: _tabController,
                  // isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.green,
                  tabs: const [
                    Tab(text: 'Info'),
                    Tab(text: 'Chargers'),
                    Tab(text: 'Check-ins'),
                    Tab(text: 'Reviews'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Info Tab
            // _buildInfoTab(),
            SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About Section
          const Text(
            'About',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labor et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Read more',
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
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
                                
                Divider(thickness: 0.5,),
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
          GestureDetector(
            onTap: () {
              
              setState(() {
                _isHoursExpanded = !_isHoursExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.green,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Open',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '24 hours',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Icon(
                  _isHoursExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          if (_isHoursExpanded) ...[
            const SizedBox(height: 16),
            _buildHoursRow('Monday', '00:00 - 00:00'),
            _buildHoursRow('Tuesday', '00:00 - 00:00'),
            _buildHoursRow('Wednesday', '00:00 - 00:00'),
            _buildHoursRow('Thursday', '00:00 - 00:00'),
            _buildHoursRow('Friday', '00:00 - 00:00'),
            _buildHoursRow('Saturday', '00:00 - 00:00'),
            _buildHoursRow('Sunday', '00:00 - 00:00'),
          ],
          const SizedBox(height: 24),

          // Amenities Section
          const Text(
            'Amenities',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 3.5,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              _buildAmenityItem(Icons.wc, 'Restrooms'),
              _buildAmenityItem(Icons.chair, 'Lounge area'),
              _buildAmenityItem(Icons.restaurant, 'Restaurant'),
              _buildAmenityItem(Icons.wifi, 'Wi-Fi'),
              _buildAmenityItem(Icons.celebration, 'Entertainment'),
              _buildAmenityItem(Icons.tire_repair, 'Air for Tyres'),
              _buildAmenityItem(Icons.store, 'Shops'),
              _buildAmenityItem(Icons.build, 'Maintenance'),
            ],
          ),
          const SizedBox(height: 24),

          // Location Section
          const Text(
            'Location',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.green, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Brooklyn, 589 Prospect Avenue',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
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
                  Container(
                    color: Colors.grey.shade300,
                  ),
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
            
            // Chargers Tab
            _buildChargersTab(),
            // Check-ins Tab
            _buildCheckInsTab(),
            // Reviews Tab
            _buildReviewsTab(),
          ],
        ),
      ),
      
    
      ),
    );
  }
}



  // Widget _buildInfoTab() {
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // About Section
  //         const Text(
  //           'About',
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 12),
  //         const Text(
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labor et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation',
  //           style: TextStyle(
  //             fontSize: 14,
  //             color: Colors.grey,
  //             height: 1.5,
  //           ),
  //         ),
  //         GestureDetector(
  //           onTap: () {},
  //           child: const Text(
  //             'Read more',
  //             style: TextStyle(
  //               fontSize: 14,
  //               color: Colors.green,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 24),

  //         // Parking and Payment Info
  //         Container(
  //           padding: const EdgeInsets.all(16),
  //           decoration: BoxDecoration(
  //             color: Colors.grey.shade50,
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Parking',
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: Colors.grey.shade600,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 4),
  //                   const Text(
  //                     'Cost',
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Text(
  //                     'Pay',
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: Colors.grey.shade600,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 4),
  //                   const Text(
  //                     'Payment is required',
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 24),

  //         // Operating Hours
  //         GestureDetector(
  //           onTap: () {
              
  //             setState(() {
  //               _isHoursExpanded = !_isHoursExpanded;
  //             });
  //           },
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Row(
  //                 children: [
  //                   Icon(
  //                     Icons.access_time,
  //                     color: Colors.green,
  //                     size: 20,
  //                   ),
  //                   const SizedBox(width: 8),
  //                   const Text(
  //                     'Open',
  //                     style: TextStyle(
  //                       color: Colors.green,
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 8),
  //                   const Text(
  //                     '24 hours',
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Icon(
  //                 _isHoursExpanded
  //                     ? Icons.keyboard_arrow_up
  //                     : Icons.keyboard_arrow_down,
  //                 color: Colors.grey,
  //               ),
  //             ],
  //           ),
  //         ),
  //         if (_isHoursExpanded) ...[
  //           const SizedBox(height: 16),
  //           _buildHoursRow('Monday', '00:00 - 00:00'),
  //           _buildHoursRow('Tuesday', '00:00 - 00:00'),
  //           _buildHoursRow('Wednesday', '00:00 - 00:00'),
  //           _buildHoursRow('Thursday', '00:00 - 00:00'),
  //           _buildHoursRow('Friday', '00:00 - 00:00'),
  //           _buildHoursRow('Saturday', '00:00 - 00:00'),
  //           _buildHoursRow('Sunday', '00:00 - 00:00'),
  //         ],
  //         const SizedBox(height: 24),

  //         // Amenities Section
  //         const Text(
  //           'Amenities',
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         GridView.count(
  //           shrinkWrap: true,
  //           physics: const NeverScrollableScrollPhysics(),
  //           crossAxisCount: 2,
  //           childAspectRatio: 3.5,
  //           mainAxisSpacing: 12,
  //           crossAxisSpacing: 12,
  //           children: [
  //             _buildAmenityItem(Icons.wc, 'Restrooms'),
  //             _buildAmenityItem(Icons.chair, 'Lounge area'),
  //             _buildAmenityItem(Icons.restaurant, 'Restaurant'),
  //             _buildAmenityItem(Icons.wifi, 'Wi-Fi'),
  //             _buildAmenityItem(Icons.celebration, 'Entertainment'),
  //             _buildAmenityItem(Icons.tire_repair, 'Air for Tyres'),
  //             _buildAmenityItem(Icons.store, 'Shops'),
  //             _buildAmenityItem(Icons.build, 'Maintenance'),
  //           ],
  //         ),
  //         const SizedBox(height: 24),

  //         // Location Section
  //         const Text(
  //           'Location',
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 12),
  //         Row(
  //           children: [
  //             Icon(Icons.location_on, color: Colors.green, size: 20),
  //             const SizedBox(width: 8),
  //             const Expanded(
  //               child: Text(
  //                 'Brooklyn, 589 Prospect Avenue',
  //                 style: TextStyle(
  //                   fontSize: 14,
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         Container(
  //           height: 200,
  //           decoration: BoxDecoration(
  //             color: Colors.grey.shade200,
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(12),
  //             child: Stack(
  //               alignment: Alignment.center,
  //               children: [
  //                 Container(
  //                   color: Colors.grey.shade300,
  //                 ),
  //                 Icon(
  //                   Icons.ev_station,
  //                   size: 60,
  //                   color: Colors.green,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 24),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildChargersTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.ev_station,
                    color: Colors.green,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Charger ${index + 1}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tesla Supercharger V3',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '250 kW',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: index % 3 == 0 ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    index % 3 == 0 ? 'Available' : 'In Use',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCheckInsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.green.shade100,
                  child: Text(
                    'U${index + 1}',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User ${index + 1}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Checked in ${index + 1} hours ago',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Charging at station ${(index % 6) + 1}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.more_vert,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${index + 1} days ago',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: List.generate(5, (starIndex) {
                        return Icon(
                          starIndex < 4 ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Great charging station! Clean facilities and fast charging speeds. Would definitely recommend to other EV owners.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHoursRow(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            hours,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityItem(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }


// Custom delegate for sticky tab bar
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _StickyTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}