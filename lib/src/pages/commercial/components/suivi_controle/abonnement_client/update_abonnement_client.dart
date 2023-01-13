import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/suivi_controle/abonnement_client_model.dart'; 
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/abonnement_client_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/button_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';


class UpdateAbonnementClient extends StatefulWidget {
  const UpdateAbonnementClient({super.key, required this.abonnementClientModel});
  final AbonnementClientModel abonnementClientModel;

  @override
  State<UpdateAbonnementClient> createState() => _UpdateAbonnementClientState();
}

class _UpdateAbonnementClientState extends State<UpdateAbonnementClient> {
  final AbonnementClientController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercials"; 

  String getPlageDate() {
    if (controller.dateFinContrat == null) {
      return 'Date de Debut et Fin';
    } else {
      return '${DateFormat('dd/MM/yyyy').format(controller.dateFinContrat!.start)} - ${DateFormat('dd/MM/yyyy').format(controller.dateFinContrat!.end)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, widget.abonnementClientModel.nomSocial),
      drawer: const DrawerMenu(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: !Responsive.isMobile(context),
              child: const Expanded(flex: 1, child: DrawerMenu())),
          Expanded(
              flex: 5,
              child: SingleChildScrollView(
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
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TitleWidget(title: "Nouveau rapport"),
                                  const SizedBox(
                                    height: p30,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: p20),
                                    child: ButtonWidget(
                                      text: getPlageDate(),
                                      onClicked: () => setState(() {
                                        pickDateRange(context);
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                      }),
                                    ),
                                  ),
                                  montantWidget(),
                                  signataireContratWidget(),
                                  const SizedBox(
                                    height: p20,
                                  ),
                                  BtnWidget(
                                      title: 'Soumettre',
                                      isLoading: controller.isLoading,
                                      press: () {
                                        final form =
                                            controller.formKey.currentState!;
                                        if (form.validate()) {
                                          controller.submitUpdate(widget.abonnementClientModel);
                                          form.reset();
                                        }
                                      })
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  Widget typeContratWidget() {
    List<String> suggestionList = ['-', 'Abonnement', 'Licence'];
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Type Contrat',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.typeContrat,
        isExpanded: true,
        validator: (value) => value == null ? "Select Type Contrat" : null,
        items: suggestionList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.typeContrat = value;
          });
        },
      ),
    );
  }

  Widget montantWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.montantController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Montant',
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

  Widget signataireContratWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.signataireContratController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: "Signataire",
              hintText: "Signataire du Contrat d'autre part"),
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

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.input,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 20),
      initialDateRange: controller.dateFinContrat ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() => controller.dateFinContrat = newDateRange);
  }
}