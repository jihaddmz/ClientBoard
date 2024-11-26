import 'package:clientboard/custom_color.dart';
import 'package:clientboard/feature_global/components/custom_button.dart';
import 'package:clientboard/feature_global/components/custom_card.dart';
import 'package:clientboard/feature_global/components/custom_textfield.dart';
import 'package:clientboard/feature_global/helper/helper_dialog.dart';
import 'package:clientboard/feature_global/helper/helper_constants.dart';
import 'package:clientboard/feature_project/model/model_project.dart';
import 'package:clientboard/feature_project/state/provider_newproject.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../feature_global/components/custom_text.dart';

class ScreenCreateProject extends StatefulWidget {
  const ScreenCreateProject({super.key});

  @override
  State<ScreenCreateProject> createState() => _ScreenCreateProjectState();
}

class _ScreenCreateProjectState extends State<ScreenCreateProject> {
  final List<String> _collaborators = [];

  // String _selectedDateTime;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDesc = TextEditingController();
  final TextEditingController _controllerBudget = TextEditingController();
  final TextEditingController _controllerFeatures = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (context
        .read<ProviderNewProject>()
        .users == null) {
      context.read<ProviderNewProject>().fetchUsers();
    }

    return Scaffold(
      backgroundColor: CustomColors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
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
                  customHeader("New Project")
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              customCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customHeader("Project Details"),
                      const SizedBox(
                        height: 20,
                      ),
                      customCard(
                          paddingValue: 0,
                          color: CustomColors.black,
                          customTextFieldWithController(
                              inputType: TextInputType.text,
                              context,
                              _controllerName, (name) {}, hintText: "Name*"),
                          1),
                      customCard(
                          paddingValue: 0,
                          color: CustomColors.black,
                          customTextFieldWithController(
                              inputType: TextInputType.text,
                              minLines: 2,
                              maxLines: 3,
                              context,
                              _controllerDesc, (desc) {},
                              hintText: "Description*"),
                          1),
                      customCard(
                          paddingValue: 0,
                          color: CustomColors.black,
                          customTextFieldWithController(
                              inputType: TextInputType.number,
                              context,
                              _controllerBudget, (budget) {},
                              hintText: "Budget in USD*"),
                          0.7),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_month),
                                const SizedBox(
                                  width: 10,
                                ),
                                customParagraph("Deadline")
                              ],
                            ),
                            onTap: () {
                              _pickDateTime(context);
                            },
                          ),
                          customCaption(context
                              .watch<ProviderNewProject>()
                              .selectedDateTime ??
                              "")
                        ],
                      ),
                    ],
                  ),
                  1),
              const SizedBox(
                height: 20,
              ),
              customCard(
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.note_add),
                          const SizedBox(
                            width: 10,
                          ),
                          customSubHeader("Additional notes")
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      customCard(
                          paddingValue: 0,
                          color: CustomColors.black,
                          customTextFieldWithController(
                              context,
                              _controllerFeatures,
                              labelText: "Features*",
                              hintText: "- User signup & login\n- Push Notifications\n- Add to cart items",
                              inputType: TextInputType.multiline,
                              minLines: 3,
                              maxLines: 10,
                                  (features) {}),
                          1),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _collaborators.length,
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customParagraph(_collaborators[index]),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _collaborators.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.delete_forever))
                              ],
                            );
                          }),
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                                backgroundColor: CustomColors.black,
                                foregroundColor: CustomColors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {},
                            child: PopupMenuButton(
                              color: CustomColors.black,
                              onSelected: (value) {
                                if (!_collaborators.contains(value)) {
                                  setState(() {
                                    _collaborators.add(value);
                                  });
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return context
                                    .read<ProviderNewProject>()
                                    .users!
                                    .map((user) =>
                                    PopupMenuItem(
                                        value: user,
                                        child: customCaption(user)))
                                    .toList();
                              },
                              child: customParagraph("Add collaborators"),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                          value: context
                              .watch<ProviderNewProject>()
                              .selectedMobilePlatform,
                          dropdownColor: CustomColors.black,
                          hint: customCaption("Mobile Platform"),
                          isExpanded: true,
                          items:
                          <String>["Android", "iOS", "Both"].map((element) {
                            return DropdownMenuItem(
                                value: element,
                                child: customParagraph(element));
                          }).toList(),
                          onChanged: (option) {
                            context
                                .read<ProviderNewProject>()
                                .selectedMobilePlatform = option;
                          }),
                    ],
                  ),
                  1),
              const SizedBox(
                height: 30,
              ),
              customButton(
                  text: "Create",
                  widthFactor: 1,
                  onClick: () async {
                    if (validateFields(context)) {
                      HelperDialog.showLoadingDialog(context);
                      await context.read<ProviderNewProject>().addProject(
                          ModelProject(
                              _controllerName.text,
                              context
                                  .read<ProviderNewProject>()
                                  .selectedDateTime!,
                              _controllerDesc.text,
                              _controllerFeatures.text,
                              context
                                  .read<ProviderNewProject>()
                                  .selectedMobilePlatform!,
                              _controllerBudget.text,
                              _collaborators));
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      HelperDialog.showWarningDialog(
                          context, "Please fill all required fields");
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  bool validateFields(BuildContext context) {
    return _controllerName.text.isNotEmpty &&
        _controllerDesc.text.isNotEmpty &&
        _controllerBudget.text.isNotEmpty &&
        _controllerFeatures.text.isNotEmpty &&
        context
            .read<ProviderNewProject>()
            .selectedMobilePlatform != null &&
        context
            .read<ProviderNewProject>()
            .selectedDateTime != null;
  }

  void _pickDateTime(BuildContext context) async {
    // Pick Date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return; // User canceled the date picker

    // Pick Time
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return; // User canceled the time picker

    // Combine Date and Time
    context
        .read<ProviderNewProject>()
        .selectedDateTime =
        HelperConstants.dateTimeFormat.format(DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        ));
  }
}
