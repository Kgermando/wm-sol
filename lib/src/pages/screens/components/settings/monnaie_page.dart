import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart'; 
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';

class MonnaiePage extends StatefulWidget {
  const MonnaiePage({super.key});

  @override
  State<MonnaiePage> createState() => _MonnaiePageState();
}

class _MonnaiePageState extends State<MonnaiePage> {
  final MonnaieStorage controller = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Settings";
  String subTitle = "Monnaie";

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
      drawer: const DrawerMenu(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("nouveau projet"),
        tooltip: "Ajouter nouveau projet",
        icon: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) { 
                return Padding(
                  padding: const EdgeInsets.all(p20),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                                child: Text("New Projet",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall)),
                          ],
                        ),
                        const SizedBox(
                          height: p20,
                        ),
                        ResponsiveChildWidget(
                          child1: symbolWidget(),
                          child2: monnaieEnLettreWidget()),
                        const SizedBox(
                          height: p20,
                        ),
                        Obx(() => BtnWidget(
                            title: 'Soumettre',
                            press: () {
                              final form = controller.formKey.currentState!;
                              if (form.validate()) {
                                controller.submit();
                                form.reset();
                                Navigator.of(context).pop();
                              }
                            },
                            isLoading: controller.isLoading))
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: !Responsive.isMobile(context),
              child: const Expanded(flex: 1, child: DrawerMenu())),
          Expanded(
              flex: 5,
              child: controller.obx(
                  onLoading: loadingPage(context),
                  onEmpty: const Text('Aucune donnée'),
                  onError: (error) => loadingError(context, error!), (state) {
                var isMonnaieActiveList = state!
                    .where((element) => element.monnaie == 'true')
                    .toList();

                return SingleChildScrollView(
                    controller: ScrollController(),
                    physics: const ScrollPhysics(),
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: p20, bottom: p8, right: p20, left: p20),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          Card(
                            elevation: 3,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: p20),
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    final monnaie = state[index];
                                    bool isActive = false;
                                    if (monnaie.isActive == 'true') {
                                      isActive == true;
                                    } else if (monnaie.isActive == 'false') {
                                      isActive == false;
                                    }
                                    return Obx(() => controller.isLoading
                                        ? loading()
                                        : SwitchListTile(
                                            focusNode: focusNode,
                                            title: Text(monnaie.monnaie),
                                            subtitle:
                                                Text(monnaie.monnaieEnlettre),
                                            value: isActive,
                                            onChanged: (value) {
                                              if (isMonnaieActiveList.isEmpty) {
                                                controller
                                                    .activeMonnaie(monnaie);
                                              }
                                            }));
                                  },
                                )),
                          )
                        ],
                      ),
                    ));
              }))
        ],
      ),
    );
  }

Widget symbolWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: TextFormField(
        controller: controller.monnaieEnLettreController,
        decoration: InputDecoration(
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          labelText: 'Symbol',
          hintText: 'CDF',
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

Widget monnaieEnLettreWidget() {
  return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: TextFormField(
        controller: controller.monnaieEnLettreController,
        decoration: InputDecoration(
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          labelText: 'Monnaie En Lettre',
          hintText: 'Francs Congolais',
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

  // Widget deviseWidget() {
  //   return DropdownButtonFormField<String>(
  //       decoration: const InputDecoration(
  //         labelText: 'Devise',
  //         labelStyle: TextStyle(),
  //         contentPadding: EdgeInsets.only(left: 5.0),
  //       ),
  //       value: controller.symbol,
  //       isExpanded: true,
  //       items: deviseList.map((String value) {
  //         return DropdownMenuItem<String>(
  //           value: value,
  //           child: Text(value),
  //         );
  //       }).toList(),
  //       onChanged: (value) {
  //         setState(() {
  //           controller.symbol = value;
  //         });
  //       });
  // }
}
