import 'package:ev_point/routes/app_pages.dart';
import 'package:ev_point/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SizeConfig.init(context);

    return ScreenUtilInit(
      minTextAdapt: true,
      // designSize: Size(375, 812),
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          initialRoute: AppRoutes.splashRoute,
          routes: AppPages.routes,
        );
      },
    );
  }
}
