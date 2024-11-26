import 'package:clientboard/custom_color.dart';
import 'package:clientboard/feature_auth/state/provider_auth.dart';
import 'package:clientboard/feature_global/components/custom_button.dart';
import 'package:clientboard/feature_global/components/custom_card.dart';
import 'package:clientboard/feature_global/components/custom_text.dart';
import 'package:clientboard/feature_global/components/custom_textfield.dart';
import 'package:clientboard/feature_global/helper/helper_dialog.dart';
import 'package:clientboard/feature_global/helper/helper_validate.dart';
import 'package:clientboard/feature_global/model/model_usecase_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenSignUp extends StatelessWidget {
  ScreenSignUp({super.key});

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            customCard(
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Image.asset("assets/images/image_signup.png"),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: customTitle("Client Board"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: customParagraph(
                            "Join now for managing your projects"),
                      )
                    ],
                  ),
                ),
                1),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  customTextFieldWithController(
                    context,
                    _controllerName,
                    (name) {},
                    labelText: "Name*",
                    inputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextFieldWithController(
                    context,
                    _controllerEmail,
                    (email) {},
                    labelText: "Email*",
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextFieldWithController(
                    context,
                    _controllerPassword,
                    (password) {},
                    labelText: "Password*",
                    inputType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  customButton(
                      text: "Join",
                      widthFactor: 1,
                      onClick: () async {
                        if (validateFields()) {
                          if (!HelperValidate.validateEmail(
                              _controllerEmail.text)) {
                            HelperDialog.showWarningDialog(
                                context, "Invalid Email");
                            return;
                          } else if (!HelperValidate.validatePassword(
                              _controllerPassword.text)) {
                            HelperDialog.showWarningDialog(context,
                                "Password should be at least 8 characters, containing capital, small and special letters.");
                            return;
                          }

                          HelperDialog.showLoadingDialog(context);
                          ModelUseCaseResult<AdditionalUserInfo> result =
                              await context
                                  .read<ProviderAuth>()
                                  .registerWithEmail(
                                      _controllerEmail.text,
                                      _controllerPassword.text,
                                      _controllerName.text);
                          if (result.result != null) {
                            Navigator.pop(context);
                            Navigator.popAndPushNamed(context, "/signin");
                          } else {
                            Navigator.pop(context);
                            HelperDialog.showWarningDialog(
                                context, result.errorMessage!);
                          }
                        } else {
                          HelperDialog.showWarningDialog(
                              context, "All fields are required.");
                        }
                      },
                      color: CustomColors.blue),
                  GestureDetector(
                    child: customParagraph("Already a user? Sign in"),
                    onTap: () {
                      Navigator.popAndPushNamed(context, "/signin");
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateFields() {
    return _controllerEmail.text.isNotEmpty &&
        _controllerPassword.text.isNotEmpty &&
        _controllerName.text.isNotEmpty;
  }
}
