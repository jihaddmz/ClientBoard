import 'package:clientboard/custom_color.dart';
import 'package:flutter/material.dart';

Widget customButton(
    {required String text,
    required double widthFactor,
    required VoidCallback onClick,
    Color color = CustomColors.blue}) {
  return FractionallySizedBox(
    widthFactor: widthFactor,
    child: ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
          ),
          backgroundColor: color,
          foregroundColor: CustomColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: Text(text),
    ),
  );
}
