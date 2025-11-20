import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/my_booking/booking_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/theme/app_color.dart';
import 'tabs/canceled_booking_screen.dart';
import 'tabs/completed_booking_screen.dart';
import 'tabs/upcoming_booking_screen.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: const _MyBookingScreenContent(),
    );
  }
}

class _MyBookingScreenContent extends StatefulWidget {
  const _MyBookingScreenContent({Key? key}) : super(key: key);

  @override
  State<_MyBookingScreenContent> createState() =>
      _MyBookingScreenContentState();
}

class _MyBookingScreenContentState extends State<_MyBookingScreenContent> {
  TabController? _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newController = DefaultTabController.of(context);
    if (newController != _tabController) {
      _tabController?.removeListener(_handleTabSelection);
      _tabController = newController;
      _tabController?.addListener(_handleTabSelection);
    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabSelection);
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController != null && !_tabController!.indexIsChanging) {
      Provider.of<BookingProvider>(
        context,
        listen: false,
      ).changeTab(_tabController!.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        leading: Padding(
            padding: EdgeInsets.all(10).r,
            child: SvgPicture.asset("${Constants.iconPath}logo_evPoint.svg"),
          ),
        title: Text(
          'My Booking',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.greyScale900,
            fontFamily: Constants.urbanistFont,
          ),
        ),
        actions: [
            GestureDetector(
              onTap: () {}, 
              child: SvgPicture.asset(
                "${Constants.iconPath}search.svg",
                color: AppColor.greyScale900,
                height: 30,
              ),
            ),
          ],
          actionsPadding: EdgeInsets.symmetric(horizontal: 10.w),
        backgroundColor: AppColor.white,
        elevation: 0,
        
      ),
      body: Column(
        children: [
          Container(
            color: AppColor.white,
            child: TabBar(
              indicatorColor: AppColor.primary_900,
              labelColor: AppColor.primary_900,
              unselectedLabelColor: AppColor.greyScale700,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.urbanistFont,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: Constants.urbanistFont,
              ),
              tabs: Constants.bookingTabs.map((tab) => Tab(text: tab)).toList(),
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                UpcomingBookingsScreen(),
                CompletedBookingsScreen(),
                CanceledBookingsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
