import 'package:clientboard/feature_global/components/custom_card.dart';
import 'package:clientboard/feature_global/components/custom_text.dart';
import 'package:flutter/material.dart';

import '../../custom_color.dart';

Widget itemProject(String projectName, String platforms) {
  return customCard(
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: customCaption(projectName)),
            const SizedBox(
              width: 30,
            ),
            if (platforms == "Both")
              Row(children: [
                CircleAvatar(
                    backgroundColor: CustomColors.grey,
                    radius: 20,
                    child: Image.asset("assets/images/android_round.png")),
                CircleAvatar(
                    backgroundColor: CustomColors.grey,
                    radius: 20,
                    child: Image.asset("assets/images/ios_round.png")),
              ]),
            if (platforms == "Android")
              Row(children: [
                CircleAvatar(
                    backgroundColor: CustomColors.grey,
                    radius: 20,
                    child: Image.asset("assets/images/android_round.png")),
              ]),
            if (platforms == "iOS")
              Row(children: [
                CircleAvatar(
                    backgroundColor: CustomColors.grey,
                    radius: 20,
                    child: Image.asset("assets/images/ios_round.png")),
              ])
          ]),
      1);
}
