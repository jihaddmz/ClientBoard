import 'package:clientboard/feature_global/components/custom_card.dart';
import 'package:clientboard/feature_global/components/custom_text.dart';
import 'package:flutter/material.dart';

Widget itemDetails(String label, String text) {
  return customCard(
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customSubHeader(label),
          customCaption(text),
        ],
      ),
      1);
}
