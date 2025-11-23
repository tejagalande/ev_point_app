import 'package:ev_point/controllers/book/vehicle_list_provider.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class MyVehicleScreen extends StatefulWidget {
  const MyVehicleScreen({super.key});

  @override
  State<MyVehicleScreen> createState() => _MyVehicleScreenState();
}

class _MyVehicleScreenState extends State<MyVehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VehicleListProvider(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: _buildAppBar(),
        body: Consumer<VehicleListProvider>(
          builder: (context, provider, child) {
            if (provider.vehicles.isEmpty) {
              return Center(
                child: Text(
                  "No vehicles added yet.",
                  style: TextStyles.bodyLargeMedium16.copyWith(
                    color: AppColor.greyScale500,
                  ),
                ),
              );
            }
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              itemCount: provider.vehicles.length,
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemBuilder: (context, index) {
                final vehicle = provider.vehicles[index];
                // Assuming the first vehicle is "In Use" for demo purposes, or check provider.selectedVehicleId
                final isInUse = provider.selectedVehicleId == vehicle.id;

                return Slidable(
                  key: ValueKey(vehicle.id),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.25,
                    children: [
                      CustomSlidableAction(
                        onPressed: (context) {
                          provider.removeVehicle(vehicle.id);
                        },
                        backgroundColor: AppColor.red,
                        foregroundColor: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r),
                        ),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: AppColor.greyScale50,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColor.greyScale200),
                      
                    ),
                    child: Row(
                      children: [
                        // Vehicle Image Placeholder
                        Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            // color: AppColor.greyScale100,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Image.asset(
                            vehicle.imagePath,
                            errorBuilder:
                                (context, error, stackTrace) => Icon(
                                  Icons.directions_car,
                                  size: 40,
                                  color: AppColor.primary_500,
                                ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicle.brand,
                                style: TextStyles.h6Bold18.copyWith(
                                  color: AppColor.greyScale900,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                vehicle.modelDetails,
                                style: TextStyles.bodyMediumMedium14.copyWith(
                                  color: AppColor.greyScale700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isInUse)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.primary_500,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              "In Use",
                              style: TextStyles.bodyXsmallSemiBold10.copyWith(
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        SizedBox(width: 12.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppColor.greyScale900,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back, color: AppColor.greyScale900),
      ),
      title: Text(
        "My Vehicle",
        style: TextStyles.h4Bold24.copyWith(color: AppColor.greyScale900),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Navigate to add vehicle
          },
          icon: Icon(Icons.add, color: AppColor.greyScale900, size: 28),
        ),
        SizedBox(width: 12.w),
      ],
    );
  }
}
