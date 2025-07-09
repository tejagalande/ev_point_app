import 'package:ev_point/controllers/onboard_provider.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:ev_point/views/auth/auth_option_screen.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    final onboardProvider = context.watch<OnboardProvider>();
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: onboardProvider.pageController,
            children: [
              page("${Constants.imagePath}onboard_screen1.png", "Easily find EV charging stations around you", "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
              page("${Constants.imagePath}onboard_screen2.png", "Fast and simple to make reservation & check in", "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
              page("${Constants.imagePath}onboard_screen3.png", "Make payments safely & quickly with EVPoint", "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            ],
          ),
          Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Container(
                        color: AppColor.white,
                        height: 130,
                        child: Column( 
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Text("indicator"),
                            
                            Divider(thickness: 0.5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    title: "Skip",
                                    buttonColor: AppColor.primary_50,
                                    borderRadius: 30,
                                    margin: EdgeInsets.all(10),
                                    textColor: AppColor.primary_900,
                                    onTapCallback: () {
                                      onboardProvider.skipPage();
                                    },
                                  ),
                                ),

                                Expanded(
                                  child: CustomButton( 
                                    title: "Next",
                                    margin: EdgeInsets.all(10),
                                    buttonColor: AppColor.primary_900,
                                    borderRadius: 30,
                                    isShadow: true,
                                    boldText: true,
                                    textColor: AppColor.white,
                                    
                                    onTapCallback: () {
                                      if(onboardProvider.currentPage < 2){
                                        onboardProvider.nextPage();
                                      }
                                      else{
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AuthOptionScreen(),));
                                      }
                                      // onboardProvider.nextPage();
                                      
                                      // debugPrint('current page: ${onboardProvider.currentPage}');
                                  
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

                  Positioned(
                    bottom: 150,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: onboardProvider.pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          dotHeight: 11,
                          dotWidth: 11,
                          
                          activeDotColor: AppColor.primary_900,
                          dotColor: AppColor.greyScale300,
                          paintStyle: PaintingStyle.fill
                        ),
                      ),
                    ),)

         
        
        ],
      ),
    );
  }

  Widget page(String imagePath, String title, String subTitle) {
    return Stack(
              children: [
                Positioned.fill(
              child: Image.asset(imagePath),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    height: 200,
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
                    height: 200,
                    width: double.infinity,
                    color: AppColor.white,
                    child: Column(
                      spacing: 20,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          title,
                          style: TextStyles.h3Bold32,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            subTitle,
                            style: TextStyles.bodyXlargeRegular18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 150),
                ],
              ),
            ),
              ],
            );
  }
}
