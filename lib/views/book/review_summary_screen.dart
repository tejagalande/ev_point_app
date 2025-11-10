// review_summary_screen.dart
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../controllers/book/review_summary_provider.dart';
import '../../utils/theme/app_color.dart';


class ReviewSummaryScreen extends StatelessWidget {
  const ReviewSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReviewSummaryProvider(),
      child: Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text(
          'Review Summary',
          style: TextStyle(
            color: AppColor.greyScale900,
            fontFamily: Constants.urbanistFont, 
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Divider( thickness: 0.5, ),
              CustomButton(
                    title: "Confirm Booking", 
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
                    isShadow: true,
                    
                    margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h) ,
                    borderRadius: 30.r,
                    ),
            ],
          ),
      body: Consumer<ReviewSummaryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle(title: 'Vehicle'),
                 SizedBox(height: 12.h),
                _VehicleCard(vehicle: provider.selectedVehicle),
                 SizedBox(height: 24.h),
                
                const _SectionTitle(title: 'Charging Station'),
                 SizedBox(height: 12.h),
                _ChargingStationCard(station: provider.chargingStation),
                 SizedBox(height: 24.h),
                
                const _SectionTitle(title: 'Charger'),
                 SizedBox(height: 12.h),
                _ChargerCard(charger: provider.selectedCharger),
                 SizedBox(height: 24.h),
                
                _BookingDetailsCard(
                  bookingDate: provider.bookingDate,
                  arrivalTime: provider.arrivalTime,
                  chargingDuration: provider.chargingDuration,
                ),
                 SizedBox(height: 24.h),
                
                _PricingCard(
                  amountEstimation: provider.amountEstimation,
                  tax: provider.tax,
                  totalAmount: provider.totalAmount,
                ),
                 SizedBox(height: 24.h),
                
                const _SectionTitle(title: 'Selected Payment Method'),
                 SizedBox(height: 12.h),
                _PaymentMethodCard(
                  paymentMethod: provider.selectedPaymentMethod,
                ),
                 SizedBox(height: 16.h),
                
                const _InfoBanner(),
              ],
            ),
          );
        },
      ),
    )
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Booking Confirmed'),
        content: const Text('Your booking has been confirmed successfully!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:  TextStyle(
        fontSize: 16.sp,
        fontFamily: Constants.urbanistFont,
        fontWeight: FontWeight.bold,
        color: AppColor.greyScale900,
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  final VehicleSummary? vehicle;

  const _VehicleCard({this.vehicle});

  @override
  Widget build(BuildContext context) {
    if (vehicle == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:  AppColor.greyScale50,
        borderRadius: BorderRadius.circular(16).r,
        border: Border.all( color: AppColor.greyScale200)
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                Icons.directions_car,
                size: 40,
                color: vehicle!.color,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5.h,
              children: [
                Text(
                  vehicle!.brand,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: Constants.urbanistFont,
                    color: AppColor.greyScale900,
                  ),
                ),
                
                Text(
                  vehicle!.modelDetails,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color:  AppColor.greyScale700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChargingStationCard extends StatelessWidget {
  final ChargingStationSummary? station;

  const _ChargingStationCard({this.station});

  @override
  Widget build(BuildContext context) {
    if (station == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.greyScale50,
        border: Border.all( color: AppColor.greyScale200 ),
        borderRadius: BorderRadius.circular(16).r,
      ),
      child: Row(
        spacing: 15.w,
        children: [
          SvgPicture.asset("${Constants.iconPath}free_station_icon.svg"),
   
          Expanded(
            child: Column(
              spacing: 5.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  station!.name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: Constants.urbanistFont,
                    fontWeight: FontWeight.bold,
                    color:AppColor.greyScale900,
                  ),
                ),
                
                Text(
                  station!.address,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: Constants.urbanistFont,
                    color: AppColor.greyScale700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChargerCard extends StatelessWidget {
  final ChargerSummary? charger;

  const _ChargerCard({this.charger});

  @override
  Widget build(BuildContext context) {
    if (charger == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.greyScale50,
        border: Border.all(color: AppColor.greyScale200),
        borderRadius: BorderRadius.circular(16).r,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  spacing: 10.h,
                  children: [
                    Text(
                                charger!.name,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: Constants.urbanistFont,
                                  color: AppColor.greyScale700,
                                ),
                              ),
                    Container( 
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.ev_station,
                        size: 28,
                        color: Colors.black,
                      ),
                    ),
                    
                
                   
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.h, 
            child: VerticalDivider(),
          ),
           Expanded(
             child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
               children: [
                
                 Column(
                  spacing: 10.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Max. power',
                          style: TextStyle(
                              fontSize: 16.sp,
                                  fontFamily: Constants.urbanistFont,
                                  color: AppColor.greyScale700,
                          ),
                        ),
                        
                        Text(
                          '${charger!.maxPower} kW',
                          style:  TextStyle(
                            fontSize: 24.sp,
                            fontFamily: Constants.urbanistFont,
                            fontWeight: FontWeight.bold,
                            color: AppColor.greyScale900,
                          ),
                        ),
                      ],
                    ),
               ],
             ),
           ),
        ],
      ),
    );
  }
}

class _BookingDetailsCard extends StatelessWidget {
  final String? bookingDate;
  final String? arrivalTime;
  final String? chargingDuration;

  const _BookingDetailsCard({
    this.bookingDate,
    this.arrivalTime,
    this.chargingDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.greyScale50,
        borderRadius: BorderRadius.circular(16).r,
        border: Border.all( color: AppColor.greyScale200 )
      ),
      child: Column(
        spacing: 10.h,
        children: [
          _DetailRow(
            label: 'Booking Date',
            value: bookingDate ?? 'N/A',
          ),
        
          _DetailRow(
            label: 'Time of Arrival',
            value: arrivalTime ?? 'N/A',
          ),
          
          _DetailRow(
            label: 'Charging Duration',
            value: chargingDuration ?? 'N/A',
          ),
        ],
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  final double amountEstimation;
  final double tax;
  final double totalAmount;

  const _PricingCard({
    required this.amountEstimation,
    required this.tax,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.greyScale50,
        border: Border.all(color: AppColor.greyScale200),
        borderRadius: BorderRadius.circular(16).r,
      ),
      child: Column(
        spacing: 10.h,
        children: [
          _DetailRow(
            label: 'Amount Estimation',
            value: '\$${amountEstimation.toStringAsFixed(2)}',
          ),
         
          _DetailRow(
            label: 'Tax',
            value: tax == 0 ? 'Free' : '\$${tax.toStringAsFixed(2)}',
          ),
          
          _DetailRow(
            label: 'Total Amount',
            value: '\$${totalAmount.toStringAsFixed(2)}',
            
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _DetailRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: Constants.urbanistFont,
            color:AppColor.greyScale700,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
             fontFamily: Constants.urbanistFont,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.greyScale900,
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final PaymentMethodSummary? paymentMethod;

  const _PaymentMethodCard({this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    if (paymentMethod == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.greyScale50,
        border: Border.all(color: AppColor.greyScale200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        spacing: 15.w,
        children: [
          SvgPicture.asset("${Constants.iconPath}e_wallet_icon.svg",),
          
          Text(
            paymentMethod!.name,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: Constants.urbanistFont,
              fontWeight: FontWeight.bold,
              color: AppColor.greyScale900,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.primary_50,
        borderRadius: BorderRadius.circular(12).r,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppColor.info,
              borderRadius: BorderRadius.circular(7).r,
            ),
            child: const Center(
              child: Text(
                'i',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your e-wallet will not be charged as long as you haven\'t charged it at the EV charging station',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.info,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ConfirmButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00C853),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Confirm Booking',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
