import 'package:clientboard/custom_color.dart';
import 'package:clientboard/feature_global/components/custom_card.dart';
import 'package:clientboard/feature_global/components/custom_text.dart';
import 'package:flutter/material.dart';

// sender is 0 if the current user is the one who sends this chat, otherwise 1
Widget itemChat(String name, String text, int sender, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Row(
      children: [
        if (sender == 1)
          CircleAvatar(
            radius: 20,
            backgroundColor: CustomColors.grey,
            child: customParagraph(name.substring(0, 1)),
          ),
        Expanded(
            child: customCard(customParagraph(text), 1,
                color: sender == 0 ? CustomColors.black : CustomColors.border)),
        if (sender == 0)
          CircleAvatar(
            radius: 20,
            backgroundColor: sender == 0 ? Colors.green : CustomColors.grey,
            child: customParagraph(name.substring(0, 1)),
          ),
      ],
    ),
  );
}
