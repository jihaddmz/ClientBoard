import 'package:flutter/widgets.dart';

import '../../custom_color.dart';

Widget customTitle(String text, {TextAlign align = TextAlign.start}) {
  return Text(
    text,
    textAlign: align,
    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
  );
}

Widget customHeader(String text, {TextAlign align = TextAlign.start}) {
  return Text(
    text,
    textAlign: align,
    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
  );
}

Widget customSubHeader(String text, {TextAlign align = TextAlign.start}) {
  return Text(
    text,
    textAlign: align,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  );
}

Widget customParagraph(String text, {TextAlign align = TextAlign.start}) {
  return Text(text,
      textAlign: align,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal));
}

Widget customCaption(String text, {TextAlign align = TextAlign.start, Color color = CustomColors.grey}) {
  return Text(
    text,
    textAlign: align,
    style: TextStyle(
        fontSize: 13, fontWeight: FontWeight.normal, color: color),
  );
}
