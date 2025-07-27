import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SelfiecameraProvider extends ChangeNotifier {

  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  CameraController? get controller => _controller ;
  bool get isCameraInitialized => _isCameraInitialized;

  SelfiecameraProvider() {
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    final frontCamera = _cameras!.firstWhere(
      (element) => element.lensDirection == CameraLensDirection.front,
    );
    _controller = CameraController(frontCamera, ResolutionPreset.high);
    await _controller!.initialize();
    _isCameraInitialized = true;
    notifyListeners();
  }

  Future<Map<String, String>?> takeSelfie() async {
    if (_controller != null && _controller!.value.isInitialized) {
      final image = await _controller!.takePicture();
      debugPrint("selfie image path: ${image.path}");
      debugPrint("image name: ${image.name} ");
      

      return {
        "image_path" : image.path,
        "image_name" : image.name,
      };
    }

    return {};
  }
}
