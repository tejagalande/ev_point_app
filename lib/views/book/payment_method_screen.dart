// payment_method_screen.dart
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../controllers/book/payment_method_provider.dart';
import '../../widgets/custom_button.dart';


class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentMethodProvider(),
      child: Scaffold(
      backgroundColor: AppColor.white,
            bottomNavigationBar: Consumer<PaymentMethodProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider( thickness: 0.5, ),
              CustomButton(
                    title: "Continue", 
                    // onTapCallback: () =>  provider.selectedVehicleId != null
                    //     ? () {
                    //         // Navigate to next screen with selected vehicle
                    //         final selectedVehicle = provider.getSelectedVehicle();
                    //         // Handle continue action
                    //       }
                    //     : null,
                    
                    buttonColor: AppColor.primary_900,
                    textColor: AppColor.white,
                    boldText: true,
                    margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h) ,
                    borderRadius: 30.r,
                    ),
            ],
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: AppColor.black),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text(
          'Select Payment Method',
          style: TextStyle(
            fontFamily: Constants.urbanistFont,
            color: AppColor.greyScale900,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actionsPadding: EdgeInsets.only(right: 10.w),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(10).r,
            onTap: () {
              
            },
            child: SvgPicture.asset("${Constants.iconPath}scan_black_icon.svg"))
        ],
      ),
      body: Consumer<PaymentMethodProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16), 
                  itemCount: provider.paymentMethods.length,
                  itemBuilder: (context, index) {
                    final method = provider.paymentMethods[index];
                    return _PaymentMethodCard(
                      paymentMethod: method,
                      isSelected: provider.selectedPaymentId == method.id,
                      onTap: () => provider.selectPaymentMethod(method.id),
                    );
                  },
                ),
              ),
              _AddPaymentButton(),
              // const SizedBox(height: 16),
              // _ContinueButton(
              //   onPressed: provider.selectedPaymentId != null
              //       ? () {
              //           // Navigate to next screen or process payment
              //           final selectedMethod = provider.getSelectedPaymentMethod();
              //           print('Selected payment: ${selectedMethod?.name}');
              //         }
              //       : null,
              // ),
            ],
          );
        },
      ),
    ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.paymentMethod,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColor.greyScale50,
        border: Border.all( color: AppColor.greyScale200),
        borderRadius: BorderRadius.circular(16).r,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Payment Method Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: paymentMethod.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: paymentMethod.iconWidget ??
                      Icon(
                        paymentMethod.icon,
                        size: 32,
                        color: AppColor.white,
                      ),
                ),
              ),
              const SizedBox(width: 16),
              // Payment Method Name and Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paymentMethod.name,
                      style:  TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.greyScale900,
                      ),
                    ),
                    if (paymentMethod.details != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        paymentMethod.details!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Balance or Radio Button
              if (paymentMethod.balance != null) ...[
                const SizedBox(width: 8),
                Text(
                  paymentMethod.balance!,
                  style:  TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primary_900,
                  ),
                ),
              ],
              const SizedBox(width: 12),
              // Radio Button
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? AppColor.primary_900
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                  color: AppColor.white,
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration:  BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.primary_900,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddPaymentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.greyScale50,
          borderRadius: BorderRadius.circular(25).r,
        ),
        child: InkWell(
          onTap: () {
            // Navigate to add payment method screen
          },
          borderRadius: BorderRadius.circular(20).r,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              spacing: 10.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Icon(
                  Icons.add,
                  color: AppColor.primary_900,
                  size: 24,
                ),
                
                Text(
                  'Add New Payment',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primary_900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _ContinueButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00C853),
          disabledBackgroundColor: Colors.grey[300],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: onPressed != null ? Colors.white : Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
