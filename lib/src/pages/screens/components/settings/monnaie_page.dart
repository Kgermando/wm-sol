import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

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
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
      drawer: const DrawerMenu(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Nouveau monnaie"),
        tooltip: "Ajouter nouveau monnaie",
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
                                child: Text("Ajout monnaie",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TitleWidget(title: 'Devise'),
                              IconButton(
                                  onPressed: () {
                                    controller.getList();
                                    Navigator.of(context).popAndPushNamed(
                                        SettingsRoutes.monnaiePage);
                                  },
                                  icon: const Icon(Icons.refresh,
                                      color: Colors.green))
                            ],
                          ),
                          const SizedBox(height: p20),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state!.length,
                            itemBuilder: (context, index) {
                              final monnaie = state[index];
                              bool isActive = false;
                              if (monnaie.isActive == 'true') {
                                isActive = true;
                              } else if (monnaie.isActive == 'false') {
                                isActive = false;
                              }
                              print("${monnaie.monnaie} $isActive");
                              return Card(
                                  child: Padding(
                                padding: const EdgeInsets.all(p8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.monetization_on,
                                            size: p40),
                                        const SizedBox(width: p5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: 'Symbol: ',
                                                style: bodyLarge,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: monnaie.monnaie,
                                                      style: bodyLarge!
                                                          .copyWith(
                                                              color:
                                                                  mainColor)),
                                                ],
                                              ),
                                            ),
                                            Text(monnaie.monnaieEnlettre),
                                          ],
                                        )
                                      ],
                                    ),
                                    Obx(
                                      () => controller.isLoading
                                          ? loadingMini()
                                          : Switch(
                                              value: isActive,
                                              onChanged: (value) {
                                                if (controller.monnaieActiveList
                                                    .isEmpty) {

                                                  controller
                                                      .activeMonnaie(monnaie, 'true');
                                                }
                                                if (monnaie.isActive ==
                                                    'true') {
                                                  controller
                                                      .activeMonnaie(monnaie, 'false');
                                                }
                                              }),
                                    )
                                  ],
                                ),
                              ));
                            },
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
          controller: controller.symbolController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Symbol',
            hintText: 'CDF',
          ),
          keyboardType: TextInputType.text,
          maxLength: 4,
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
}
