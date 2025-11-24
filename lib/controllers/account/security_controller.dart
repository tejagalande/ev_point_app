import 'package:flutter/material.dart';

class SecurityController extends ChangeNotifier {
  bool _rememberMe = true;
  bool _biometricId = false;
  bool _faceId = false;
  bool _smsAuthenticator = false;
  bool _googleAuthenticator = false;

  bool get rememberMe => _rememberMe;
  bool get biometricId => _biometricId;
  bool get faceId => _faceId;
  bool get smsAuthenticator => _smsAuthenticator;
  bool get googleAuthenticator => _googleAuthenticator;

  void toggleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  void toggleBiometricId(bool value) {
    _biometricId = value;
    notifyListeners();
  }

  void toggleFaceId(bool value) {
    _faceId = value;
    notifyListeners();
  }

  void toggleSmsAuthenticator(bool value) {
    _smsAuthenticator = value;
    notifyListeners();
  }

  void toggleGoogleAuthenticator(bool value) {
    _googleAuthenticator = value;
    notifyListeners();
  }
}
