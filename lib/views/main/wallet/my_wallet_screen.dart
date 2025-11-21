import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  final screenHeight = ScreenUtil().screenHeight;
  final screenWidth = ScreenUtil().screenWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.w, 5.h, 15.w, 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWalletCard(),
            const SizedBox(height: 24),
            _buildRecentTransactionsHeader(),
            const SizedBox(height: 16),
            _buildRecentTransactionsList(),
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
        padding: EdgeInsets.all(10).r,
        child: SvgPicture.asset(
          "${Constants.iconPath}logo_evPoint.svg", // Assuming a logo exists, or just use an icon
          // height: 32,
          // width: 32,
          errorBuilder:
              (context, error, stackTrace) =>
                  Icon(Icons.electric_bolt, color: AppColor.primary_500),
        ),
      ),
      leadingWidth: 56,
      title: Text(
        "My Wallet",
        style: TextStyles.h4Bold24.copyWith(color: AppColor.greyScale900),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            "${Constants.iconPath}search.svg",
            color: AppColor.greyScale900,
            height: 30.h,
          ),
        ),
      ],
      actionsPadding: EdgeInsets.symmetric(horizontal: 10.w),
    );
  }

  Widget _buildWalletCard() {
    return Stack(
      // alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.infinity,
          height: 180.h, 

          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.linearGradientGreen2,
                AppColor.linearGradientGreen1,
              ],
              stops: [-0.15, 0.7],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(32).r,
            // color: Colors.amber.shade600
            // boxShadow: [
            //   BoxShadow(
            //     color: AppColor.primary_500.withOpacity(0.4),
            //     blurRadius: 24,
            //     offset: const Offset(0, 12),
            //   ),
            // ],
          ),
          child: Image.asset(
            // width: double.infinity,
            // height: double.infinity,
            fit: BoxFit.cover,
            // color: Colors.amber,
            "${Constants.imagePath}card_bg.png",
          ),
        ),

        Padding(
          padding: EdgeInsets.all(17.0).r,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Andrew Ainsley",
                          style: TextStyles.h6Bold18.copyWith(
                            color: AppColor.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "•••• •••• •••• ••99",
                          style: TextStyles.h6Bold18.copyWith(
                            color: AppColor.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    // Visa/Mastercard Icon placeholder
                    Row(
                      children: [
                        Text(
                          "VISA",
                          style: TextStyles.h5Bold20.copyWith(
                            color: AppColor.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Circle overlap for Mastercard-ish look
                        SizedBox(
                          width: 32,
                          height: 20,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red.withOpacity(0.8),
                                  radius: 10,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.orange.withOpacity(0.8),
                                  radius: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  "Your balance",
                  style: TextStyles.bodyMediumMedium14.copyWith(
                    color: AppColor.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$957.50",
                      style: TextStyles.h2Bold40.copyWith(color: AppColor.white),
                    ),
                    InkWell(
                      onTap: () {
                        
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          spacing: 5.w,
                          children: [
                            Icon(
                              Icons.wallet_travel_rounded,
                              color: AppColor.greyScale900,
                              size: 20,
                            ), // Top up icon
                            
                            Text(
                              "Top Up",
                              style: TextStyles.bodyLargeSemiBold16.copyWith(
                                color: AppColor.greyScale900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ),
      ],
    );
  }

  Widget _buildRecentTransactionsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Recent Transactions",
          style: TextStyles.h4Bold24.copyWith(color: AppColor.greyScale900),
        ),
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              Text(
                "View All",
                style: TextStyles.bodyLargeBold16.copyWith(
                  color: AppColor.primary_900,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.arrow_forward, color: AppColor.primary_900, size: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTransactionsList() {
    // Dummy data
    final transactions = [
      {
        "title": "Walgreens - Brooklyn",
        "date": "Dec 17, 2024  •  10:00 AM",
        "amount": "- \$14.25",
        "isExpense": true,
        "icon": Icons.shopping_bag,
        "color": Colors.pinkAccent,
      },
      {
        "title": "Top Up Wallet",
        "date": "Dec 10, 2024  •  12:44 PM",
        "amount": "+ \$50.00",
        "isExpense": false,
        "icon": Icons.account_balance_wallet,
        "color": AppColor.primary_500,
      },
      {
        "title": "ImPark Underhill ...",
        "date": "Dec 05, 2024  •  14:00 PM",
        "amount": "- \$12.50",
        "isExpense": true,
        "icon": Icons.local_parking,
        "color": Colors.orange,
      },
      {
        "title": "Top Up Wallet",
        "date": "Nov 28, 2024  •  19:26 PM",
        "amount": "+ \$25.00",
        "isExpense": false,
        "icon": Icons.account_balance_wallet,
        "color": AppColor.primary_500,
      },
      {
        "title": "Rapidpark 906 U...",
        "date": "Nov 24, 2024  •  09:00 AM",
        "amount": "- \$18.00",
        "isExpense": true,
        "icon": Icons.local_parking,
        "color": Colors.red,
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final item = transactions[index];
        final isExpense = item['isExpense'] as bool;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.greyScale50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.greyScale200),
          ),
          child: Row(
            spacing: 10.w,
            children: [
              // Container(
              //   height: 50,
              //   width: 50,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: (item['color'] as Color).withOpacity(0.1),
              //   ),
              //   child: Icon(
              //     item['icon'] as IconData,
              //     color: item['color'] as Color,
              //   ),
              // ),
              Column(
                spacing: 6.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 10.w,
                    children: [
                      if (isExpense)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.red),
                            borderRadius: BorderRadius.circular(6).r,
                          ),
                          child: Text(
                            "Paid",
                            style: TextStyles.bodyXsmallSemiBold10.copyWith(
                              color: AppColor.red,
                            ),
                          ),
                        )
                      else
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.primary_900),
                            borderRadius: BorderRadius.circular(6).r,
                          ),
                          child: Text(
                            "Topup",
                            style: TextStyles.bodyXsmallSemiBold10.copyWith(
                              color: AppColor.primary_900,
                            ),
                          ),
                        ),

                      // title text
                      SizedBox(
                        width: screenWidth * 0.27.w,
                        child: Text(
                          item['title'] as String,
                          style: TextStyles.h6SemiBold18.copyWith(
                            color: AppColor.greyScale900,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  Text(
                    item['date'] as String,
                    style: TextStyles.bodySmallMedium12.copyWith(
                      color: AppColor.greyScale700,
                    ),
                  ),
                ],
              ),

              // const SizedBox(width: 16),
              const Spacer(),

              Row(
                spacing: 4.w,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item['amount'] as String,
                    style: TextStyles.h6Bold18.copyWith(
                      color: isExpense ? AppColor.red : AppColor.primary_500,
                    ),
                  ),
                  // const SizedBox(height: 6),
                  // const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColor.greyScale500,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
