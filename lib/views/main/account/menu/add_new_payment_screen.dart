import 'package:ev_point/controllers/account/add_new_payment_provider.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';

class AddNewPaymentScreen extends StatelessWidget {
  const AddNewPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddNewPaymentProvider(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: _buildAppBar(context),
        body: Consumer<AddNewPaymentProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCardPreview(provider),
                  SizedBox(height: 24.h),
                  _buildLabel("Card Holder Name"),
                  SizedBox(height: 1.h),
                  _buildTextField(
                    controller: provider.cardHolderNameController,
                    hintText: "Andrew Ainsley",
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 24.h),
                  _buildLabel("Card Number"),
                  SizedBox(height: 1.h),
                  _buildTextField(
                    controller: provider.cardNumberController,
                    hintText: "7643 5526 0254 4679",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                    ],
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      if (value.length == 16) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Expiry Date"),
                            SizedBox(height: 1.h),
                            _buildTextField(
                              controller: provider.expiryDateController,
                              hintText: "10/26",
                              suffixIcon: Icons.calendar_month,
                              readOnly: true,
                              onTap: () => provider.selectExpiryDate(context),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("CVV"),
                            SizedBox(height: 1.0.h),
                            _buildTextField(
                              controller: provider.cvvController,
                              hintText: "655",
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                if (value.length == 3) {
                                  FocusScope.of(context).unfocus();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  CustomButton(
                    title: "Add",
                    onTapCallback: () => provider.addNewPayment(context),
                    buttonColor: AppColor.primary_900,
                    textColor: AppColor.white,
                    borderRadius: 30.r,
                    fontSize: 18.sp,
                    isShadow: true,
                    boldText: true,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.close, color: AppColor.greyScale900),
      ),
      title: Text(
        "Add New Payment",
        style: TextStyles.h4Bold24.copyWith(color: AppColor.greyScale900),
      ),
    );
  }

  Widget _buildCardPreview(AddNewPaymentProvider provider) {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.primary_900, // Using primary color as base
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: AssetImage(
            "${Constants.imagePath}new_card_background.png",
          ), // Assuming a card background exists or fallback
          fit: BoxFit.fill,
          onError:
              (exception, stackTrace) {}, // Handle missing image gracefully
        ),
      ),
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Card",
                style: TextStyles.h6Bold18.copyWith(color: AppColor.white),
              ),
              // Placeholder for card type icon (Mastercard/Visa)
              Icon(
                Icons.circle,
                color: Colors.white.withOpacity(0.5),
                size: 30,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getMaskedCardNumber(provider.cardNumberController.text),
                style: TextStyles.h4Bold24.copyWith(color: AppColor.white),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Card Holder Name",
                          style: TextStyles.bodySmallRegular12.copyWith(
                            color: AppColor.white.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          provider.cardHolderNameController.text.isEmpty
                              ? "........"
                              : provider.cardHolderNameController.text,
                          style: TextStyles.bodyMediumBold14.copyWith(
                            color: AppColor.white,
                          ),
                          maxLines: 1, 
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w), // Add spacing between name and expiry
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expiry Date",
                        style: TextStyles.bodySmallRegular12.copyWith(
                          color: AppColor.white.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        provider.expiryDateController.text.isEmpty
                            ? "00/00"
                            : provider.expiryDateController.text,
                        style: TextStyles.bodyMediumBold14.copyWith(
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.w), // Add spacing
                  Text(
                    "amazon", // Logo placeholder
                    style: TextStyles.h6Bold18.copyWith(
                      color: AppColor.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getMaskedCardNumber(String number) {
    if (number.isEmpty) return ".... .... .... ....";

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < number.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }

      // Show first 4 and last 2 (indices 14, 15)
      if (i < 4 || i >= 14) {
        buffer.write(number[i]);
      } else {
        buffer.write('*');
      }
    }
    return buffer.toString();
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyles.h6Bold18.copyWith(color: AppColor.greyScale900),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? suffixIcon,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
    TextInputAction? textInputAction,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      textInputAction: textInputAction,
      style: TextStyles.h5Bold20.copyWith(color: AppColor.greyScale900),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyles.bodyLargeRegular16.copyWith(
          color: AppColor.greyScale500,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary_900),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary_900),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary_900),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 1.h),
        suffixIcon:
            suffixIcon != null
                ? Icon(suffixIcon, color: AppColor.greyScale500)
                : null,
      ),
    );
  }
}
