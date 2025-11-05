// vehicle_selection_screen.dart
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../controllers/book/vehicle_list_provider.dart';


class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({Key? key}) : super(key: key);

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VehicleListProvider(),
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
          'Select Your Vehicle',
          style: TextStyle(
            color: AppColor.greyScale900,
            fontSize: 24.sp,
            fontFamily: Constants.urbanistFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              // Navigate to add vehicle screen
            },
          ),
        ],
      ),
      bottomNavigationBar: Consumer<VehicleListProvider>(
        builder: (context, provider, child) {
          return CustomButton(
                title: "Continue", 
                onTapCallback: () =>  provider.selectedVehicleId != null
                    ? () {
                        // Navigate to next screen with selected vehicle
                        final selectedVehicle = provider.getSelectedVehicle();
                        // Handle continue action
                      }
                    : null,
                
                buttonColor: AppColor.primary_900,
                textColor: AppColor.white,
                boldText: true,
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h) ,
                borderRadius: 30.r,
                );
        },
      ),
      body: Consumer<VehicleListProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = provider.vehicles[index];
              return _VehicleCard(
                vehicle: vehicle,
                isSelected: provider.selectedVehicleId == vehicle.id,
                onTap: () => provider.selectVehicle(vehicle.id),
              );
            },
          );
        },
      ),
    )
    );
  }
}

class _VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final bool isSelected;
  final VoidCallback onTap;

  const _VehicleCard({
    required this.vehicle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColor.greyScale50,
        borderRadius: BorderRadius.circular(16).r,
        border: Border.all( color: AppColor.greyScale200)
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            
          ),
          child: Image.asset(
            vehicle.imagePath,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          vehicle.brand,
          style:  TextStyle(
            fontSize: 20.sp,
            fontFamily: Constants.urbanistFont,
            fontWeight: FontWeight.bold,
            color: AppColor.greyScale900,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            vehicle.modelDetails,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: Constants.urbanistFont,
              color: AppColor.greyScale700,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        trailing: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected 
                  ?  AppColor.primary_900
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primary_900 ,
                    ),
                  ),
                )
              : null,
        ),
        onTap: onTap,
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
