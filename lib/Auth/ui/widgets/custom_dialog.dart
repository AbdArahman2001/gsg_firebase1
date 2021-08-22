import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/helpers/router_helper.dart';

class CustomDialog {
  CustomDialog._();

  static CustomDialog customDialog = CustomDialog._();

  showCustomDialog(String message, [Function function]) {
    showDialog(
        context: RouterHelper.router.navKey.currentContext,
        builder: (context) => AlertDialog(
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      RouterHelper.router.back();
                      if (function != null) function();
                    },
                    child: Text('ok')),
              ],
            ));
  }
}
