import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/suivi_controle/entreprise_info_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/abonnement_client_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/button_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class AddAbonnementClient extends StatefulWidget {
  const AddAbonnementClient({super.key, required this.entrepriseInfoModel});
  final EntrepriseInfoModel entrepriseInfoModel;

  @override
  State<AddAbonnementClient> createState() => _AddAbonnementClientState();
}

class _AddAbonnementClientState extends State<AddAbonnementClient> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final AbonnementClientController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercials";
  String subTitle = "New Abonnement client";

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
      appBar: headerBar(context, scaffoldKey, title, subTitle),
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
                                  const TitleWidget(title: "Nouveau contract"),
                                  const SizedBox(
                                    height: p30,
                                  ),
                                  ResponsiveChildWidget(
                                      child1: typeContratWidget(),
                                      child2: signataireContratWidget()), 
                                  ResponsiveChildWidget(
                                    child1: Container(
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
                                  child2: montantWidget()),
                                  ResponsiveChildWidget(
                                      child1: fichierWidget(),
                                      child2: Container()), 
                                  const SizedBox(
                                    height: p20,
                                  ),
                                  Obx(() => BtnWidget(
                                    title: 'Soumettre',
                                    isLoading: controller.isLoading,
                                    press: () {
                                      final form =
                                          controller.formKey.currentState!;
                                      if (form.validate()) {
                                        controller.submit(widget.entrepriseInfoModel);
                                        form.reset();
                                      }
                                    }
                                  )) 
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
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.montantController, 
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Montant',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(width: p20),
            Expanded(
              child: Text(monnaieStorage.monney, style: Theme.of(context).textTheme.headline6))
          ],
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
            hintText: "Signataire du Contrat d'autre part"
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

  Widget fichierWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: Obx(() => controller.isUploading
          ? const SizedBox(
              height: p20, width: 50.0, child: LinearProgressIndicator())
          : TextButton.icon(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'png', 'jpg'],
                );
                if (result != null) {
                  controller.uploadFile(result.files.single.path!);
                } else {
                  const Text("Votre fichier n'existe pas");
                }
              },
              icon: controller.isUploadingDone
                  ? Icon(Icons.check_circle_outline,
                      color: Colors.green.shade700)
                  : const Icon(Icons.upload_file),
              label: controller.isUploadingDone
                  ? Text("Upload terminé",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.green.shade700))
                  : Text("Joindre le contract",
                      style: Theme.of(context).textTheme.bodyLarge))));
  }
}
