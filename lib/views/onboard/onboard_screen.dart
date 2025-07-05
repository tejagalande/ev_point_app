import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:flutter/material.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              Stack(
                children: [
                  Positioned.fill(child: Image.asset("asset/image/onboard_screen1.png"),),
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
                              end: Alignment.bottomCenter
                            )
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
                                "Easily find EV charging stations around you",
                                style: TextStyles.h3Bold32,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", style: TextStyles.bodyXlargeRegular18,),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 150,)
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: SizedBox(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("indicator"),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(onPressed: (){}, child: Text("Skip")),
                                ElevatedButton(onPressed: (){}, child: Text("Next")),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      )
    );
  }
}