import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  
  // Check current permission status
  static Future<PermissionStatus> checkPermission(Permission permissionType) async {
    
    return await permissionType.status;
  }
  
  // Request notification permission with proper handling
  static Future<PermissionStatus> requestPermission(Permission permissionType) async {
    PermissionStatus status = await permissionType.status;
    
    if (status.isGranted) {
      return status;
    }
    
    if (status.isDenied) {
      // Permission is denied but can still be requested
      status = await permissionType.request();
      return status;
    }
    
    if (status.isPermanentlyDenied) {
      // Permission is permanently denied, need to open settings
      await _showPermissionDialog();
      return status;
    }
    
    // For unknown status, request permission
    status = await permissionType.request();
    return status;
  }
  
  // Handle different permission states
  static Future<void> handlePermission(Permission permissionType) async {
    PermissionStatus status = await checkPermission(permissionType);
    
    switch (status) {
      case PermissionStatus.granted:
        log('${permissionType.runtimeType} permission granted');
        // Proceed with notification setup
        break;
        
      case PermissionStatus.denied:
        log('${permissionType.runtimeType} permission denied, requesting...');
        PermissionStatus newStatus = await permissionType.request();
        _handlePermissionResult(newStatus);
        break;
        
      case PermissionStatus.permanentlyDenied:
        log('${permissionType.runtimeType} permission permanently denied');
        await _showPermissionDialog();
        break;
        
      case PermissionStatus.restricted:
        log('${permissionType.runtimeType} permission restricted');
        break;
        
      default:
        log('Unknown permission status, requesting...');
        PermissionStatus newStatus = await permissionType.request();
        _handlePermissionResult(newStatus);
    }
  }
  
  // Handle the result after requesting permission
  static void _handlePermissionResult(PermissionStatus status) {
    if (status.isGranted) {
      log('Permission granted!');
      // Initialize notification services
    } else if (status.isDenied) {
      log('Permission denied by user');
      // Show explanation or fallback UI
    } else if (status.isPermanentlyDenied) {
      log('Permission permanently denied');
      // Show dialog to open settings
      _showPermissionDialog();
    }
  }
  
  // Show dialog for permanently denied permissions
  static Future<void> _showPermissionDialog() async {
    // You'll need to implement this with your preferred dialog method
    // This opens the app settings where user can manually enable notifications
    await openAppSettings();
  }
  
  // Check if permission is permanently denied
  static Future<bool> isPermissionPermanentlyDenied(Permission permissionType) async {
    PermissionStatus status = await permissionType.status;
    return status.isPermanentlyDenied;
  }
}
