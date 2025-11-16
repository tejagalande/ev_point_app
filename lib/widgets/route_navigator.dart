import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';

class RouteNavigator extends StatelessWidget {
  const RouteNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: AppColor.primary_900,
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColor.primary_900.withAlpha(70),
            AppColor.primary_900,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Transform.rotate(
        angle: 13.2,
        child: Icon(
          Icons.navigation,
          color: AppColor.white,
        ),
      ),
    );
  }
}
