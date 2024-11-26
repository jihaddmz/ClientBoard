import 'package:clientboard/custom_color.dart';
import 'package:flutter/material.dart';

Widget customTextFieldWithController(
  BuildContext context,
  TextEditingController controller,
  Function(String) onValueChange, {
  int maxLines = 1,
  int minLines = 1,
  Widget? suffixIcon,
  bool enabled = true,
  String? labelText,
  String hintText = "",
  TextInputType inputType = TextInputType.text,
}) {
  return TextFormField(
    controller: controller,
    onChanged: (value) {
      onValueChange(value);
    },
    enabled: enabled,
    keyboardType: inputType,
    minLines: minLines,
    maxLines: maxLines,
    decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: const TextStyle(color: CustomColors.grey),
        labelText: labelText,
        labelStyle: const TextStyle(color: CustomColors.grey),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.border, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.border, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.border, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        )),
  );
}
