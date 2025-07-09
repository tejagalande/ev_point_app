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
  EdgeInsets? margin;

  void Function()? onTapCallback;


  CustomButton({super.key, required this.title, this.isBorder, this.boldText, this.buttonColor, this.textColor, this.borderRadius, this.isShadow, this.margin , this.isPrefixIcon , this.onTapCallback});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapCallback,
      child: Container(
        margin: widget.margin,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular( widget.borderRadius != null ? widget.borderRadius! : 0.0 ),
          boxShadow: [
            widget.isShadow == true && widget.isShadow != null ? BoxShadow(
              color: AppColor.greyScale400,
              offset: Offset(0.0, 3.0),
              blurRadius: 9,
              spreadRadius: 0
            ) : BoxShadow()
          ]
        ),
        child : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: widget.isPrefixIcon != null && widget.isPrefixIcon == true ? 15.0 : 0.0,
          children: [
            widget.isPrefixIcon != null && widget.isPrefixIcon == true ? SvgPicture.asset("${Constants.iconPath}navigation_bold.svg") : SizedBox.shrink(),
            Text(
              widget.title,
              style: TextStyle(fontFamily: Constants.urbanistFont,  fontWeight: widget.boldText == true && widget.boldText != null ? FontWeight.w800 : FontWeight.w600, fontSize: 16 , color: widget.textColor ),
              
              ),
          ],
        ),
      ),
    );
  }
}