import 'package:clientboard/custom_color.dart';
import 'package:clientboard/feature_global/components/custom_card.dart';
import 'package:clientboard/feature_global/components/custom_text.dart';
import 'package:clientboard/feature_global/helper/helper_dialog.dart';
import 'package:clientboard/feature_global/state/provider_app.dart';
import 'package:clientboard/feature_project/components/item_details.dart';
import 'package:clientboard/feature_project/state/provider_project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/provider_chat.dart';

class ScreenProjectDetails extends StatelessWidget {
  ScreenProjectDetails({super.key});

  final TextEditingController _controllerDesc = TextEditingController();
  final TextEditingController _controllerDeadline = TextEditingController();
  final TextEditingController _controllerFeatures = TextEditingController();
  final TextEditingController _controllerBudget = TextEditingController();

  late ProviderProject providerProject;

  @override
  Widget build(BuildContext context) {
    providerProject = Provider.of(context);
    ProviderApp providerApp = Provider.of(context);

    _controllerDeadline.text =
        providerProject.project!.deadlineEdited.isNotEmpty
            ? providerProject.project!.deadlineEdited
            : providerProject.project!.deadline;
    _controllerDesc.text = providerProject.project!.descriptionEdited.isNotEmpty
        ? providerProject.project!.descriptionEdited
        : providerProject.project!.description;
    _controllerFeatures.text =
        providerProject.project!.featuresEdited.isNotEmpty
            ? providerProject.project!.featuresEdited
            : providerProject.project!.features;
    _controllerBudget.text =
        "\$ ${providerProject.project!.budgetEdited.isNotEmpty ? providerProject.project!.budgetEdited : providerProject.project!.budget}";

    _controllerDesc.text = _controllerDesc.text.replaceAll("\\n", "\n");
    _controllerFeatures.text = _controllerFeatures.text.replaceAll("\\n", "\n");

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios)),
                      customHeader("Project Details")
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        if (validateEnteredEditedDetails()) {
                          HelperDialog.showBottomSheet(context,
                              "Are you sure you want to request edit for project: ${providerProject.project!.name}?",
                              () async {
                            HelperDialog.showLoadingDialog(context);
                            await providerProject
                                .editProject(providerProject.project!);
                            context.read<ProviderChat>().addChat(
                                providerProject.project!.name,
                                "Send a request update, pls check it out!");
                            Navigator.pop(context);
                            providerProject
                                .refreshProject(providerProject.project!);
                          });
                        } else {
                          HelperDialog.showWarningDialog(
                              context, "No edits has been detected!");
                        }
                      },
                      icon: const Icon(Icons.edit_note))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              itemDetails(context, _controllerDesc, "Description",
                  providerProject.project!.descriptionEdited.isEmpty,
                  color: providerProject.project!.descriptionEdited.isNotEmpty
                      ? Colors.red
                      : CustomColors.grey),
              const SizedBox(
                height: 20,
              ),
              itemDetails(context, _controllerDeadline, "Deadline",
                  providerProject.project!.deadlineEdited.isEmpty,
                  color: providerProject.project!.deadlineEdited.isNotEmpty
                      ? Colors.red
                      : CustomColors.grey),
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
              itemDetails(context, _controllerFeatures, "Features",
                  providerProject.project!.featuresEdited.isEmpty,
                  color: providerProject.project!.featuresEdited.isNotEmpty
                      ? Colors.red
                      : CustomColors.grey,
                  inputType: TextInputType.multiline),
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
                              ],
                            );
                          })
                    ],
                  ),
                  1),
              const SizedBox(
                height: 20,
              ),
              itemDetails(context, _controllerBudget, "Budget",
                  providerProject.project!.budgetEdited.isEmpty,
                  color: providerProject.project!.budgetEdited.isNotEmpty
                      ? Colors.red
                      : CustomColors.grey),
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

  bool validateEnteredEditedDetails() {
    bool result = false;
    if (_controllerDesc.text != providerProject.project!.description &&
        _controllerDesc.text != providerProject.project!.descriptionEdited) {
      providerProject.project!.descriptionEdited = _controllerDesc.text;
      result = true;
    }

    if (_controllerDeadline.text != providerProject.project!.deadline &&
        _controllerDeadline.text != providerProject.project!.deadlineEdited) {
      providerProject.project!.deadlineEdited = _controllerDeadline.text;
      result = true;
    }

    if (_controllerFeatures.text != providerProject.project!.features &&
        _controllerFeatures.text != providerProject.project!.featuresEdited) {
      providerProject.project!.featuresEdited = _controllerFeatures.text;
      result = true;
    }

    if (_controllerBudget.text != "\$ ${providerProject.project!.budget}" &&
        _controllerBudget.text !=
            "\$ ${providerProject.project!.budgetEdited}") {
      providerProject.project!.budgetEdited = _controllerBudget.text;
      result = true;
    }

    return result;
  }
}
