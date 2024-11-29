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

  static void showBottomSheet(
      BuildContext context, String text, VoidCallback onYesClick) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        backgroundColor: CustomColors.border,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FractionallySizedBox(
                    widthFactor: 0.7,
                    child: customParagraph(text, align: TextAlign.center)),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: customButton(
                            text: "No",
                            widthFactor: 0.7,
                            onClick: () {
                              Navigator.pop(context);
                            })),
                    Expanded(
                      child: customButton(
                          text: "Yes",
                          widthFactor: 0.7,
                          onClick: () {
                            Navigator.pop(context);
                            onYesClick();
                          }),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
