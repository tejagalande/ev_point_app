
import 'package:ev_point/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget backArrow() {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset("${Constants.iconPath}left_arrow.svg",),
      );
  }