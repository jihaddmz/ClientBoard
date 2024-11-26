import 'package:clientboard/feature_auth/state/provider_auth.dart';
import 'package:clientboard/feature_global/components/custom_button.dart';
import 'package:clientboard/feature_global/components/custom_text.dart';
import 'package:clientboard/feature_global/components/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../custom_color.dart';
import '../../feature_global/helper/helper_dialog.dart';
import '../../feature_global/helper/helper_validate.dart';
import '../../feature_global/model/model_usecase_result.dart';

class ScreenSignIn extends StatelessWidget {
  ScreenSignIn({super.key});

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: CustomColors.black,
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Align(
            alignment: Alignment.center,
            child: customTitle("Log in"),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                customTextFieldWithController(
                    context, _controllerEmail, (email) {},
                    labelText: "Email*", inputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 10,
                ),
                customTextFieldWithController(
                    context, _controllerPassword, obscureText: true, (password) {},
                    labelText: "Password*",
                    inputType: TextInputType.visiblePassword),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: customCaption("Forgot your password?"),
                    onTap: () async {
                      if (_controllerEmail.text.isEmpty) {
                        HelperDialog.showWarningDialog(context,
                            " Please enter your email on which you would like to receive a reset link.");
                      } else {
                        HelperDialog.showLoadingDialog(context);
                        bool result = await context
                            .read<ProviderAuth>()
                            .resetPassword(_controllerEmail.text);
                        Navigator.pop(context);
                        if (result) { // success sending the reset email
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: customParagraph(
                                  "Your reset link was sent to ${_controllerEmail.text}")));
                        } else {
                          HelperDialog.showWarningDialog(context, "Make sure the email you've entered is valid, and you have signed up with!");
                        }

                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                customButton(
                    text: "Sign in",
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

                        ModelUseCaseResult<User> result = await context
                            .read<ProviderAuth>()
                            .signInWithEmail(_controllerEmail.text,
                                _controllerPassword.text);
                        if (result.result != null) {
                          Navigator.pop(context);
                          Navigator.popAndPushNamed(context, "/home");
                        } else {
                          Navigator.pop(context);
                          HelperDialog.showWarningDialog(
                              context, result.errorMessage!);
                        }
                      } else {
                        HelperDialog.showWarningDialog(
                            context, "All fields are required.");
                      }
                    }),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/signup");
                  },
                  child: customParagraph("New to Client Board? Join now!"),
                )
              ],
            ),
          ),
        ],
      )),
    ));
  }

  bool validateFields() {
    return _controllerEmail.text.isNotEmpty &&
        _controllerPassword.text.isNotEmpty;
  }
}
