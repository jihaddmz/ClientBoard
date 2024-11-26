import 'package:clientboard/custom_color.dart';
import 'package:flutter/material.dart';

Widget customCard(Widget child, double widthFactor,
    {Color color = CustomColors.border, double paddingValue = 20}) {
  return FractionallySizedBox(
    widthFactor: widthFactor,
    child: Card(
      color: color,
      child: Padding(
        padding: EdgeInsets.all(paddingValue),
        child: child,
      ),
    ),
  );
}
