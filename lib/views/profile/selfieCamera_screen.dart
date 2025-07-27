import 'package:camera/camera.dart';
import 'package:ev_point/controllers/selfieCamera_provider.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SelfiecameraScreen extends StatefulWidget {
  const SelfiecameraScreen({super.key});

  @override
  State<SelfiecameraScreen> createState() => _SelfiecameraScreenState();
}

class _SelfiecameraScreenState extends State<SelfiecameraScreen> {

  @override
  Widget build(BuildContext context) {
    final selfieProvider = context.watch<SelfiecameraProvider>();
    return Scaffold(
      body: SafeArea( 
        child: Center(
          child: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                child: selfieProvider.isCameraInitialized ?  CameraPreview(selfieProvider.controller!) : Center(child: CircularProgressIndicator()) ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    selfieProvider.takeSelfie().then((imagePath) {
                      Navigator.pop(context, imagePath);
                    },).catchError((error){
                      debugPrint("error in selfie camera screen: $error");
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.cyan
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}