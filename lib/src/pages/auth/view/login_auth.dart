import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/style.dart';
import 'package:wm_solution/src/pages/auth/controller/login_controller.dart';
import 'package:wm_solution/src/utils/info_system.dart';
import 'package:wm_solution/src/widgets/custom_text.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class LoginAuth extends GetView<LoginController> {
  const LoginAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset(InfoSystem().logo(), height: 100),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text("Login",
                        style: headlineMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CustomText(
                      text: "Bienvenue sur l'interface ${InfoSystem().name()}.",
                      color: lightGrey,
                    ),
                  ],
                ),
                const SizedBox(
                  height: p16,
                ),
                matriculeBuild(),
                passwordBuild(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(text: "Mot de passe oublié ?", color: mainColor)
                  ],
                ),
                const SizedBox(
                  height: p16,
                ),
                btnBuilder(),
                const SizedBox(
                  height: p16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget matriculeBuild() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Matricule',
          ),
          controller: controller.matriculeController,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ce champ est obligatoire';
            }
            return null;
          },
          style: const TextStyle(),
        ));
  }

  Widget passwordBuild() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Mot de passe',
          ),
          controller: controller.passwordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ce champ est obligatoire';
            }
            return null;
          },
          style: const TextStyle(),
        ));
  }

  Widget btnBuilder() {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: InkWell(
        onTap: controller.login,
        child: Container(
          decoration: BoxDecoration(
              color: mainColor, borderRadius: BorderRadius.circular(20)),
          alignment: Alignment.center,
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: controller.isLoadingLogin
              ? loading()
              : const CustomText(
                  text: "Login",
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
