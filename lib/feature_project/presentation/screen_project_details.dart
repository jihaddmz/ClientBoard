import 'package:clientboard/custom_color.dart';
import 'package:clientboard/feature_global/components/custom_card.dart';
import 'package:clientboard/feature_global/components/custom_text.dart';
import 'package:clientboard/feature_global/state/provider_app.dart';
import 'package:clientboard/feature_project/components/item_details.dart';
import 'package:clientboard/feature_project/state/provider_project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/provider_chat.dart';

class ScreenProjectDetails extends StatelessWidget {
  const ScreenProjectDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderProject providerProject = Provider.of(context);
    ProviderApp providerApp = Provider.of(context);

    if (providerApp.isOnline == null) {
      providerApp
          .fetchOnlineStatus(providerProject.project!.collaborators.first);
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: CustomColors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const SizedBox(
                    width: 20,
                  ),
                  customHeader("Project Details")
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              itemDetails("Description", providerProject.project!.description),
              const SizedBox(
                height: 20,
              ),
              itemDetails("Deadline", providerProject.project!.deadline),
              const SizedBox(
                height: 20,
              ),
              customCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customSubHeader("Mobile Platforms"),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: WidgetStatePropertyAll(
                                providerProject.project!.platforms == "iOS" ||
                                        providerProject.project!.platforms ==
                                            "Both"
                                    ? CustomColors.blue
                                    : Colors.transparent),
                            value: providerProject.project!.platforms ==
                                    "iOS" ||
                                providerProject.project!.platforms == "Both",
                            onChanged: (value) {},
                          ),
                          customCaption("iOS"),
                          const SizedBox(
                            width: 30,
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: WidgetStatePropertyAll(providerProject
                                            .project!.platforms ==
                                        "Android" ||
                                    providerProject.project!.platforms == "Both"
                                ? CustomColors.blue
                                : Colors.transparent),
                            value: providerProject.project!.platforms ==
                                    "Android" ||
                                providerProject.project!.platforms == "Both",
                            onChanged: (value) {},
                          ),
                          customCaption("Android")
                        ],
                      )
                    ],
                  ),
                  1),
              const SizedBox(
                height: 20,
              ),
              itemDetails("Features",
                  providerProject.project!.features.replaceAll("\\n", "\n")),
              const SizedBox(
                height: 20,
              ),
              customCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customSubHeader("Collaborators"),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              providerProject.project!.collaborators.length,
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customParagraph(providerProject
                                    .project!.collaborators[index]),
                                // IconButton(
                                //     onPressed: () {},
                                //     icon: const Icon(Icons.delete_forever))
                              ],
                            );
                          })
                    ],
                  ),
                  1),
              const SizedBox(
                height: 20,
              ),
              itemDetails("Budget", "\$${providerProject.project!.budget}"),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: customCard(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customSubHeader("Chat"),
                        Row(
                          children: [
                            customCaption(
                                providerApp.isOnline! ? "Online" : "Offline"),
                            const SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              backgroundColor: providerApp.isOnline!
                                  ? CustomColors.green
                                  : Colors.red,
                              radius: 10,
                            )
                          ],
                        )
                      ],
                    ),
                    1),
                onTap: () {
                  context.read<ProviderChat>().fetchSnapshots(
                      context.read<ProviderProject>().project!.name);
                  Navigator.pushNamed(context, "/chat");
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
