import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udevs_tz/src/core/colors/colors.dart';
import 'package:udevs_tz/src/core/extentions/text_styles.dart';


class Helper {
  //ERROR SNACKBAR
  static void showErrorSnackbar({
    required BuildContext context,
    String errorMessage = 'Something went wrong',
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.C_EE2B00.withOpacity(.8),
        content: Text(
          errorMessage,
          style: context.displayMedium?.copyWith(
            color: AppColors.C_FFFFFF,
          ),
        ),
      ),
    );
  }

//SUCCESS SNACKBAR
  static void showSuccessSnackbar({
    required BuildContext context,
    required String successMessage,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.C_008000.withOpacity(.8),
        content: Text(
          successMessage,
          style: context.displayMedium?.copyWith(
            color: AppColors.C_FFFFFF,
          ),
        ),
      ),
    );
  }

  //Message
  static void showMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static void showAlertMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.C_056EA1,
      textColor: AppColors.C_FFFFFF,
    );
  }

  //Convert String Hex to Color
  static Color hexToColor(String code) {
    String valueString = code.split('0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  //Dismissable Dialog
  static void showDismissableDialog(BuildContext context) {
    showDialog(
      barrierLabel: '',
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: Container(
          height: 90.0,
          width: 90.0,
          decoration: BoxDecoration(
            color: AppColors.C_FFFFFF,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
