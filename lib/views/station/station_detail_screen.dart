import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ev_point/controllers/station/station_detail_provider.dart';
import 'package:ev_point/routes/app_routes.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/views/station/tab/charger_tab.dart';
import 'package:ev_point/views/station/tab/info_tab.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class StationDetailScreen extends StatefulWidget {
  const StationDetailScreen({super.key});

  @override
  State<StationDetailScreen> createState() => _StationDetailScreenState();
}

class _StationDetailScreenState extends State<StationDetailScreen>
    with SingleTickerProviderStateMixin {
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
  
    return Scaffold(
      backgroundColor: AppColor.white,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Divider(thickness: 0.5,),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
            child: Row(
              spacing: 15.w,
              children: [
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Container(
                    padding: EdgeInsets.all(10).r,
                    decoration: BoxDecoration(
                      color: AppColor.primary_900.withAlpha(20),
                      shape: BoxShape.circle,
                  
                    ),
                    child: SvgPicture.asset("${Constants.iconPath}scan_icon.svg", height: 30,)),
                ),
                Expanded(
                  child: CustomButton(
                    title: "Book",
                    boldText: true,
                    buttonColor: AppColor.primary_900,
                    textColor: AppColor.white,
                    borderRadius: 25.r,
                    onTapCallback: () {
                      
                    },
                    ),
                )
              ],
            ),
          )
        ],
      ),
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
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  ),
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
                padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 1.h),
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
                      style: TextStyle(fontSize: 14, color: Colors.grey),
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
                          initialRating: double.parse('4.5'),
                          maxRating: 5,
                        ),
                        Text(
                          "(130 reviews)",
                          style: TextStyle(
                            fontFamily: Constants.urbanistFont,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.greyScale600,
                          ),
                        ),
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
    
                    Divider(thickness: 0.5),
    
                    // Action Buttons
                    Row(
                      spacing: 20.w,
                      children: [
                        // view button
                        Expanded(
                          child: CustomButton(
                            title: "Get Direction",
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            buttonColor: AppColor.primary_900,
    
                            borderRadius: 30.r,
                            textColor: AppColor.white,
                            onTapCallback: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.stationDetailRoute,
                              );
                            },
                          ),
                        ),
    
                        // book button
                        Expanded(
                          child: CustomButton(
                            border: Border.all(
                              color: AppColor.primary_900,
                              width: 2.w,
                            ),
                            title: "Route Planner",
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            buttonColor: AppColor.white,
                            textColor: AppColor.primary_900,
                            borderRadius: 30.r,
                            onTapCallback: () {},
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 0.5),
                    // const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
    
            // Tab Bar
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: _StickyTabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
    
                    // padding: EdgeInsets.symmetric(horizontal: 15.w),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColor.primary_900,
                    tabAlignment: TabAlignment.start,
                    indicatorAnimation: TabIndicatorAnimation.elastic,
                    unselectedLabelColor: AppColor.greyScale500,
                    labelStyle: TextStyle(
                      fontFamily: Constants.urbanistFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                    indicatorColor: AppColor.primary_900,
                    tabs: const [
                      Tab(text: 'Info'),
                      Tab(text: 'Chargers'),
                      Tab(text: 'Check-ins'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
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
            InfoTab(),
    
            // Chargers Tab
            ChargerTab(),
            // Check-ins Tab
            _buildCheckInsTab(),
            // Reviews Tab
            _buildReviewsTab(),
          ],
        ),
      ),
    );
  }
}

Widget _buildCheckInsTab() {
  return ListView.builder(
    padding: const EdgeInsets.all(20),
    itemCount: 10,
    itemBuilder: (context, index) {
      return Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
              Icon(Icons.more_vert, color: Colors.grey.shade400),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
    return Container(color: Colors.white, child: tabBar);
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
