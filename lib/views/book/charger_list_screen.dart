// charger_selection_screen.dart
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../controllers/book/charger_list_provider.dart';
import '../../widgets/custom_button.dart';


class ChargerListScreen extends StatefulWidget {
  const ChargerListScreen({super.key});

  @override
  State<ChargerListScreen> createState() => _ChargerListScreenState();
}

class _ChargerListScreenState extends State<ChargerListScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChargerListProvider(),
      child: Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text(
          'Select Charger',
          style: TextStyle(
            color: AppColor.greyScale900,
            fontSize: 24.sp,
            fontFamily: Constants.urbanistFont,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
        bottomNavigationBar: Consumer<ChargerListProvider>(
        builder: (context, provider, child) {
          return CustomButton(
                title: "Continue", 
                onTapCallback: () =>  provider.selectedChargerId != null
                    ? () {
                        // Navigate to next screen with selected charger
                        final selectedCharger = provider.getSelectedCharger();
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
      body: Consumer<ChargerListProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            padding:  EdgeInsets.all(16).r,
            itemCount: provider.chargers.length,
            itemBuilder: (context, index) {
              final charger = provider.chargers[index];
              return _ChargerCard(
                charger: charger,
                isSelected: provider.selectedChargerId == charger.id,
                onTap: () => provider.selectCharger(charger.id),
              );
            },
          );
        },
      ),
    ),
    );
  }
}

class _ChargerCard extends StatelessWidget {
  final Charger charger;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChargerCard({
    required this.charger,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColor.greyScale50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.greyScale200)
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(16).r,
          child: Row(
            children: [
              // Charger Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    _getChargerIcon(charger.type),
                    size: 36,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // Charger Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          charger.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: Constants.urbanistFont,
                            color: AppColor.greyScale700,
                            
                          ),
                        ),
                        SizedBox(width: 8.h),
                        Text(
                          '·',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                         SizedBox(width: 8.h),
                        Text(
                          charger.currentType,
                          style: TextStyle(
                           fontSize: 16.sp,
                            fontFamily: Constants.urbanistFont,
                            color: AppColor.greyScale700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          'Max. power',
                          style: TextStyle(
                             fontSize: 16.sp,
                            fontFamily: Constants.urbanistFont,
                            color: AppColor.greyScale700,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                     SizedBox(height: 4.h),
                    Text(
                      '${charger.maxPower} kW',
                      style:  TextStyle(
                        fontSize: 24.sp,
                        color: AppColor.greyScale900,
                        fontFamily: Constants.urbanistFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
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

  IconData _getChargerIcon(ChargerType type) {
    switch (type) {
      case ChargerType.tesla:
        return Icons.ev_station;
      case ChargerType.mennekes:
        return Icons.power;
      case ChargerType.chademo:
        return Icons.power_rounded;
      case ChargerType.ccs1:
        return Icons.electric_bolt;
      case ChargerType.ccs2:
        return Icons.electric_bolt_outlined;
      case ChargerType.j1772:
        return Icons.charging_station;
    }
  }
}


