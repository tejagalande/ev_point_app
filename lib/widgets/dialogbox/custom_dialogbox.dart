import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../loader.dart';

Future<Widget> customDialogBox(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "${Constants.imagePath}sign_up_successfull.png",
                height: 200,
              ),
              SizedBox(height: 30),
              Text(
                "Sign up Successful!",
                style: TextStyle(
                  fontFamily: Constants.urbanistFont,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  color: AppColor.primary_900,
                ),
              ),
              Text(
                "Please wait...",
                style: TextStyle(
                  fontFamily: Constants.urbanistFont,
                  fontSize: 16,
                  color: AppColor.greyScale900,
                ),
              ),
              Text(
                "You will be directed to the homepage.",
                style: TextStyle(
                  fontFamily: Constants.urbanistFont,
                  fontSize: 16,
                  color: AppColor.greyScale900,
                ),
              ),
              SizedBox(height: 30),
              CustomCircularLoader(),
            ],
          ),
        ),
      );
    },
  );
}
