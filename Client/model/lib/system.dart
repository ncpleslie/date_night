import 'package:model/base.dart';

mixin SystemModel on BaseModel {
  bool _isLightMode = true;
  bool _isSystemLightDarkMode = false;
  bool get isLightMode => _isLightMode;
  bool get isSystemLightDarkMode => _isSystemLightDarkMode;

  void toggleIsLightMode(bool state) {
    _isLightMode = state;
  }

  void toggleIsSystemLightDarkMode(bool state) {
    _isSystemLightDarkMode = state;
  }
}
