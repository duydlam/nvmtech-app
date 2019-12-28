import 'package:flutter/material.dart';
import 'package:nvmtech/core/bloc/base.dart';
import 'package:nvmtech/core/store/shared_preferences.dart';
import 'package:nvmtech/core/widgets/toast/base_toast.dart';
import 'package:nvmtech/src/constants/sharedPreference_constant.dart';
import 'package:nvmtech/src/types/app_type.dart';
import 'package:nvmtech/src/types/theme_type.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {
  GlobalKey<NavigatorState> _navigatorKey;

  final BehaviorSubject<ThemeType> _theme =
      BehaviorSubject<ThemeType>.seeded(ThemeType.Light);

  void sinkThemeType(dynamic value) => this._theme.sink.add(value);
  ValueObservable<ThemeType> get streamThemeType => this._theme.stream;

  SharedPreferencesWrapper _sPreferencesWrapper;

  AppBloc(navigatorKey) {
    this._navigatorKey = navigatorKey;
    SharedPreferencesWrapper.getInstance()
        .then((sf) => this._sPreferencesWrapper = sf);
  }

  NavigatorState getNavigator() {
    return this._navigatorKey.currentState;
  }

  void setupApp() async {
    final bool isFirstTime = this._isFirstTime();

    if (isFirstTime) {
      this._navigatorKey.currentState.pushReplacementNamed('/welcome');
      return;
    }

    bool isLoggined = this._isLoggined();
    if (!isLoggined) {
      this._navigatorKey.currentState.pushReplacementNamed('/login');
      return;
    }
  }

  static void toastMessage(BuildContext context, String message,
      [ToastType toastType = ToastType.Info]) {
    Color toastColor;
    Color toastTextColor;
    Icon toastIcon;
    Color iconRectangleColor;
    
    switch (toastType) {
      case ToastType.Success:
        {
          toastColor = Color(0xffDCF4D9);
          toastTextColor = Color(0xff5a724c);
          toastIcon = Icon(Icons.check, size: 30, color: toastTextColor);
          iconRectangleColor = Color(0xffc8e0bd);
          break;
        }
        
      case ToastType.Error:
        {
          toastColor = Color(0xfff2c8c6);
          toastTextColor = Color(0xff9d2f29);
          toastIcon = Icon(Icons.clear, size: 30, color: toastTextColor,);
          iconRectangleColor = Color(0xffe7aaa5);
          break;
        }
        break;
      
      default:
        toastColor = Colors.white;
    }
    return Toast.show(message, 
      context, 
      backgroundColor: toastColor, 
      textColor: toastTextColor,
      icon: toastIcon,
      iconRectangleColor: iconRectangleColor,
      gravity: Toast.TOP);
  }

  bool _isLoggined() =>
      this._sPreferencesWrapper.getSPreferences().getBool(CONST_LOGGINED) ??
      false;

  bool _isFirstTime() =>
      this._sPreferencesWrapper.getSPreferences().getBool(CONST_FIRST_TIME) ??
      true;

  @override
  void dispose() async {
    this._navigatorKey = null;
    this._sPreferencesWrapper = null;

    await this._theme?.drain();
    this._theme.close();
  }
}
