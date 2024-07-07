import 'package:flutter/painting.dart';

import '../colors/colors.dart';

abstract class AppConstants {
  //Routes
  static const String mainPage = '/';
  static const String addEventPage = '/add_event_page';
  static const String detailEventPage = '/detail_event_page';
  static const String editEventPage = '/edit_event_page';
  // static DateTime dateTime = DateTime.now();

  //EVENT COLORS
  static List<Color> colors = [
    AppColors.C_008000,
    AppColors.C_EE2B00,
    AppColors.C_EE8F00,
  ];
}
