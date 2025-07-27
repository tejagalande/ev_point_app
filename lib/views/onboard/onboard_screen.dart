import 'package:ev_point/controllers/onboard_provider.dart';
import 'package:ev_point/routes/app_routes.dart';
import 'package:ev_point/utils/size_config.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:ev_point/views/auth/auth_option_screen.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/constants.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getHeight();
  }

  // Future<double> getHeight() async{

  //     final position = box.localToGlobal(Offset.zero);
  //     debugPrint("subtitle text position: $position");
  //     subtitleHeight =  box.size.height;
  //     debugPrint("height: ${box.size.height} and width: ${box.size.width}");

  //   return subtitleHeight;
  // }

  @override
  Widget build(BuildContext context) {
    final onboardProvider = context.watch<OnboardProvider>();
    double screenHeight = ScreenUtil().screenHeight;
    double screenWidth = ScreenUtil().screenWidth;
    debugPrint(
      "height: $screenHeight and width: $screenWidth and pixelRatio: ${ScreenUtil().pixelRatio}",
    );
    return Scaffold(
      backgroundColor: AppColor.white,

      body: Stack(
        children: [
          onboardProvider.bottomButtonRenderBox != null &&
                  onboardProvider.bottomButtonRenderBox!.hasSize
              ? PageView(
                controller: onboardProvider.pageController,
                onPageChanged: (value) {
                  // debugPrint("page changed $value");
                  onboardProvider.updatePage(value);
                },
                children: [
                  page(
                    "${Constants.imagePath}onboard_screen1.png",
                    Constants.title1,
                    Constants.subTitle1,
                  ),
                  page(
                    "${Constants.imagePath}onboard_screen2.png",
                    Constants.title2,
                    Constants.subTitle1,
                  ),
                  page(
                    "${Constants.imagePath}onboard_screen3.png",
                    Constants.title3,
                    Constants.subTitle1,
                  ),
                ],
              )
              : SizedBox.shrink(),

          // page indicator, divider, and two buttons
          Positioned(
            
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              key:  ScreenUtil().screenHeight > 687 ? onboardProvider.bottomButtonKey : null,
              child: Container(
                // key: ScreenUtil().screenHeight < 687 ? onboardProvider.bottomButtonKey : null,
                
                // color: AppColor.white,
                // height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    SmoothPageIndicator(
                      controller: onboardProvider.pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        dotHeight: 11.h,
                        dotWidth: 11.w,

                        activeDotColor: AppColor.primary_900,
                        dotColor: AppColor.greyScale300,
                        paintStyle: PaintingStyle.fill,
                      ),
                    ),
                    SizedBox(height: 20.0.h,),
                    Divider(thickness: 0.5.w),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: CustomButton(
                            title: "Skip",
                            buttonColor: AppColor.primary_50,
                            borderRadius: 30.r,
                            margin: EdgeInsets.all(10.dg),
                            textColor: AppColor.primary_900,
                            onTapCallback: () {
                              onboardProvider.skipPage();
                            },
                          ),
                        ),

                        Expanded(
                          child: CustomButton(
                            title: "Next",
                            margin: EdgeInsets.all(10.dg),
                            buttonColor: AppColor.primary_900,
                            borderRadius: 30.r,
                            isShadow: true,
                            boldText: true,
                            textColor: AppColor.white,

                            onTapCallback: () {
                              if (onboardProvider.currentPage < 3) {
                                onboardProvider.nextPage();
                              } else {
                                Navigator.pushNamed(context, AppRoutes.signupRoute);
                              }
                              // onboardProvider.nextPage();

                              debugPrint(
                                'current page: ${onboardProvider.currentPage}',
                              );
                            },
                          ),
                        ),
                      ],
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

  Widget page(String imagePath, String title, String subTitle) {
    // debugPrint("${context.read<OnboardProvider>().subtitleHeight}");
    return Stack(
      children: [
        Positioned(top: 20.h, right: 0, left: 0, child: Image.asset(imagePath)),

        Positioned(
          bottom: context.read<OnboardProvider>().subtitleHeight + 0.h  ,
          // bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            // spacing: 30,
            children: [
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  // color: Colors.blueAccent,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withAlpha(10),
                      Colors.white.withAlpha(50),
                      Colors.white.withAlpha(90),
                      Colors.white.withAlpha(220),
                      Colors.white.withAlpha(240),
                      Colors.white.withAlpha(255),
                    ],
                    // stops: [0.2, 0.4, 0.6, 0.8 , 1.0 ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Container(
                // height: 200.h,
                width: double.infinity,
                color: AppColor.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
                  child: Column(
                    spacing: 20.h,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        title,
                        style: TextStyles.h3Bold32,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        subTitle,
                        style: TextStyles.bodyXlargeRegular18,
                      ),
       
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
