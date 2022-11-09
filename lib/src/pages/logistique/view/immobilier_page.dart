import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/components/immobiliers/table_immobilier.dart';
import 'package:wm_solution/src/pages/logistique/controller/immobiliers/immobilier_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';

class ImmobilierPage extends StatefulWidget {
  const ImmobilierPage({super.key});

  @override
  State<ImmobilierPage> createState() => _ImmobilierPageState();
}

class _ImmobilierPageState extends State<ImmobilierPage> {
  final ImmobilierController controller = Get.put(ImmobilierController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "Immobiliers";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (data) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title, subTitle),
              drawer: const DrawerMenu(),
              floatingActionButton: FloatingActionButton.extended(
                label: const Text("Ajouter un immobilier"),
                tooltip: "Ajouter un nouveau immobilier",
                icon: const Icon(Icons.add),
                onPressed: () {
                  newFicheDialog();
                },
              ),
              body: Row(
                children: [
                  Visibility(
                      visible: !Responsive.isMobile(context),
                      child: const Expanded(flex: 1, child: DrawerMenu())),
                  Expanded(
                      flex: 5,
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: p20, right: p20, left: p20, bottom: p8),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TableImmobilier(
                              immobilierList: controller.immobilierList,
                              controller: controller))),
                ],
              ))),
    );
  }

  newFicheDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) { 
            return AlertDialog(
              scrollable: true,
              title:
                  Text('Ajout immobilier', style: TextStyle(color: mainColor)),
              content: SizedBox(
                  height: Responsive.isDesktop(context) ? 350 : 600,
                  width: 500,
                  child: Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              ResponsiveChildWidget(
                                  child1: typeAllocationWidget(),
                                  child2: adresseWidget()),
                              ResponsiveChildWidget(
                                  child1: numeroCertificatWidget(),
                                  child2: superficieWidget()),
                              dateAcquisitionWidget(),
                              const SizedBox(
                                height: p20,
                              ),
                            ],
                          ))),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    final form = controller.formKey.currentState!;
                    if (form.validate()) {
                      controller.submit();
                      form.reset();
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Widget typeAllocationWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.typeAllocationController,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: 'Type d\'Allocation',
              hintText: 'Bureau, Entrepôt,...'),
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

  Widget adresseWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.adresseController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Adresse',
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

  Widget numeroCertificatWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.numeroCertificatController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Certificat',
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

  Widget superficieWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.superficieController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Superficie en m²',
            hintText: 'M²'
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

  Widget dateAcquisitionWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: DateTimePicker(
          initialEntryMode: DatePickerEntryMode.input,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.date_range),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Date d\'acquisition',
          ),
          controller: controller.dateAcquisitionController,
          firstDate: DateTime(1930),
          lastDate: DateTime(2100),
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
