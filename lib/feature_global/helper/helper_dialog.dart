import 'package:clientboard/custom_color.dart';
import 'package:clientboard/feature_global/components/custom_button.dart';
import 'package:clientboard/feature_global/components/custom_text.dart';
import 'package:flutter/material.dart';

class HelperDialog {
  static void showWarningDialog(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AlertDialog(
                backgroundColor: CustomColors.border,
                title: customHeader("Warning!", align: TextAlign.center),
                content: customParagraph(text, align: TextAlign.center),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  customButton(
                      text: "OK",
                      widthFactor: 0.9,
                      onClick: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            ));
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const AlertDialog(
                backgroundColor: CustomColors.border,
                content: SizedBox(
                  width: 70,
                  height: 70,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: CustomColors.blue,
                    ),
                  ),
                ),
              ),
            ));
  }
}
