import 'package:clientboard/feature_global/components/custom_card.dart';
import 'package:clientboard/feature_global/components/custom_text.dart';
import 'package:clientboard/feature_global/components/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../custom_color.dart';

Widget itemDetails(BuildContext context, TextEditingController controller, String label, bool enabled, {Color color = CustomColors.grey}) {
  return customCard(
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customSubHeader(label),
          customTextFieldWithController(context, controller, enabled: enabled, (value){}, color: color, maxLines: 10)
          // customCaption(text, color: color),
        ],
      ),
      1);
}
