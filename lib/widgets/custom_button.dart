import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomButton extends StatefulWidget {
  String title;
  bool? isBorder;
  bool? boldText;
  Color? buttonColor;
  Color? textColor;
  double? borderRadius;
  bool? isShadow;
  bool? isPrefixIcon;

  void Function()? onTapCallback;


  CustomButton({super.key, required this.title, this.isBorder, this.boldText, this.buttonColor, this.textColor, this.borderRadius, this.isShadow, this.onTapCallback});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapCallback,
      child: Container(
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular( widget.borderRadius != null ? widget.borderRadius! : 0.0 ),
      
        ),
        child : Row(
          children: [
            widget.isPrefixIcon != null && widget.isPrefixIcon == true ? SvgPicture.asset("${Constants.iconPath}navigation_bold.svg")
            Text(
              "Skip",
              style: TextStyle(fontFamily: Constants.urbanistFont,  fontWeight: widget.boldText == true ? FontWeight.w800 : FontWeight.w600, fontSize: 16 , color: widget.textColor ),
              
              ),
          ],
        ),
      ),
    );
  }
}