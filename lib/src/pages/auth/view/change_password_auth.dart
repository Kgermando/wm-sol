import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/pages/auth/controller/change_password_controller.dart';  
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class ChangePasswordAuth extends GetView<ChangePasswordController> {
   const ChangePasswordAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Form(
      key: controller.changePasswordFormKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(p16),
              child: SizedBox(
                width: Responsive.isDesktop(context)
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const TitleWidget(title: 'Modifier votre mot de passe'),
                    const SizedBox(
                      height: p20,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        "Bonjour ${controller.user.prenom}, votre sécurité passe avant tout!",
                        maxLines: 3,
                        style: bodyLarge,
                      ),
                    ),
                    const SizedBox(height: p30),
                    newPasswordWidget(), 
                    const SizedBox(
                      height: p20,
                    ),
                    BtnWidget(
                      title: 'Soumettre',
                      isLoading: controller.isLoadingChangePassword,
                      press: controller.submitChangePassword
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget newPasswordWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.changePasswordController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nouveau mot de passe',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  
}
