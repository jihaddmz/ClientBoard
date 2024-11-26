import 'package:clientboard/feature_global/components/custom_card.dart';
import 'package:clientboard/feature_global/components/custom_textfield.dart';
import 'package:clientboard/feature_global/helper/helper_sharedpref.dart';
import 'package:clientboard/feature_project/components/Item_chat.dart';
import 'package:clientboard/feature_project/state/provider_chat.dart';
import 'package:clientboard/feature_project/state/provider_project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../custom_color.dart';
import '../../feature_global/components/custom_text.dart';

class ScreenChat extends StatelessWidget {
  const ScreenChat({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return SafeArea(
        child: Scaffold(
      backgroundColor: CustomColors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                customHeader("Chat")
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: context.watch<ProviderChat>().snapshots,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: customSubHeader("Error: ${snapshot.error}"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: CustomColors.blue,
                      ),
                    );
                  }
                  return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((doc) {
                        final sender =
                            HelperSharedPref.getUsername() == doc.get("sender")
                                ? 0
                                : 1;
                        return itemChat(doc.get("sender"), doc.get("text"),
                            sender, context);
                      }).toList());
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: customCard(
                          paddingValue: 0,
                          customTextFieldWithController(
                              context, controller, (message) {},
                              hintText: "Type a message"),
                          1)),
                  Card(
                      color: CustomColors.blue,
                      child: IconButton(
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            context.read<ProviderChat>().addChat(
                                context
                                    .read<ProviderProject>()
                                    .project!
                                    .name,
                                controller.text);
                            controller.clear();
                          }
                        },
                        icon: const Icon(Icons.send),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
