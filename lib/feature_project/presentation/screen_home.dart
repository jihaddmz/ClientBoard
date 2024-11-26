import 'package:clientboard/custom_color.dart';
import 'package:clientboard/feature_global/components/custom_button.dart';
import 'package:clientboard/feature_global/components/custom_card.dart';
import 'package:clientboard/feature_global/components/custom_text.dart';
import 'package:clientboard/feature_global/helper/helper_sharedpref.dart';
import 'package:clientboard/feature_project/components/item_project.dart';
import 'package:clientboard/feature_project/state/provider_project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});


  @override
  Widget build(BuildContext context) {
    ProviderProject providerProject = Provider.of<ProviderProject>(context);

    if (context.read<ProviderProject>().projects == null) {
      context.read<ProviderProject>().fetchProjects();
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: CustomColors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              customHeader("Hello\n\t\t\t${HelperSharedPref.getUsername()}"),
              const SizedBox(
                height: 50,
              ),
              customCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customSubHeader("Create New Project",
                          align: TextAlign.start),
                      const SizedBox(
                        height: 30,
                      ),
                      customButton(
                          text: "New Project",
                          widthFactor: 0.5,
                          onClick: () {
                            Navigator.pushNamed(context, "/new_project");
                          })
                    ],
                  ),
                  1),
              const SizedBox(
                height: 50,
              ),
              customParagraph("Your Projects"),
              const SizedBox(
                height: 10,
              ),
              if (providerProject.projects != null)
                Column(
                  children: providerProject.projects!.map((project) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        child: itemProject(project.name, project.platforms),
                        onTap: () {
                          providerProject.project = project;
                          Navigator.pushNamed(context, "/project_details");
                        },
                      ),
                    );
                  }).toList(),
                )
            ],
          ),
        ),
      ),
    ));
  }
}
