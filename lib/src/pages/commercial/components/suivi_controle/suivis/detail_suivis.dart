import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial/components/suivi_controle/suivis/table_suivis.dart';
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/entreprise_infos_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/suivis_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class DetailSuivis extends StatefulWidget {
  const DetailSuivis({super.key, required this.dateTime});
  final DateTime dateTime;

  @override
  State<DetailSuivis> createState() => _DetailSuivisState();
}

class _DetailSuivisState extends State<DetailSuivis> {
  final SuivisController controller = Get.put(SuivisController());
  final EntrepriseInfosController entrepriseInfosController =
      Get.put(EntrepriseInfosController());
  final ProfilController profilController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";
  String subTitle = "Suivis";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenu(),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Ajouter un suivi"),
          tooltip: "Ajouter un nouveau suivi",
          icon: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              useRootNavigator: true,
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(p20),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: [
                                Expanded(
                                    child: Text("Nouveau suivi",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall)),
                              ],
                            ),
                            const SizedBox(
                              height: p20,
                            ),
                            nomSocialWidget(),
                            accuseeReceptionWidget(),
                            travailEffectueWidget(),
                            backgroundWidget(),
                            const SizedBox(
                              height: p20,
                            ),
                            Obx(() => BtnWidget(
                                title: 'Soumettre',
                                press: () {
                                  final form = controller.formKey.currentState!;
                                  if (form.validate()) {
                                    controller.submit(widget.dateTime);
                                    form.reset();
                                  }
                                },
                                isLoading: controller.isLoading))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        body: Row(
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenu())),
            Expanded(
                flex: 5,
                child: controller.obx(
                    onLoading: loadingPage(context),
                    onEmpty: const Text('Aucune donnée'),
                    onError: (error) => loadingError(context, error!),
                    (state) => Container(
                        margin: const EdgeInsets.only(
                            top: p20, right: p20, left: p20, bottom: p8),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TableSuivis(
                          controller: controller,
                          state: state!
                              .where((element) =>
                                  DateFormat("dd-MM-yyyy")
                                      .format(element.createdDay) ==
                                  DateFormat("dd-MM-yyyy")
                                      .format(widget.dateTime))
                              .toList(),
                          dateTime: widget.dateTime,
                        )))),
          ],
        ));
  }

  Widget nomSocialWidget() {
    var dataList = entrepriseInfosController.entrepriseInfosList
        .map((e) => e.nomSocial)
        .toList();
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Nom Social',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.nomSocial,
        isExpanded: true,
        items: dataList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select Nom Social" : null,
        onChanged: (value) {
          setState(() {
            controller.nomSocial = value!;
          });
        },
      ),
    );
  }

  Widget accuseeReceptionWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.accuseeReceptionController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: "Accusée Reception",
          ),
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

  Widget travailEffectueWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.travailEffectueController,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: 5,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Travail Effectué',
          ),
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

  Widget backgroundWidget() {
    List<String> suggestionList = ['Effectuer', 'Interrompu', 'Non Effectuer'];
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Travail',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.eventName,
        isExpanded: true,
        validator: (value) => value == null ? "Select Type background" : null,
        items: suggestionList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() { 
            if (value == 'Effectuer') {
              controller.background = 0xFF43A047.toString();
            } else if (value == 'Interrompu') {
              controller.background = 0xFFFF9000.toString();
            } else if (value == 'Non Effectuer') {
              controller.background = 0xFFE53935.toString();
            }
            controller.eventName = value;
          });
        },
      ),
    );
  }
}
