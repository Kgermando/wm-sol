import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/devis/components/table_devis.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DevisPage extends StatefulWidget {
  const DevisPage({super.key});

  @override
  State<DevisPage> createState() => _DevisPageState();
}

class _DevisPageState extends State<DevisPage> {
  final DevisController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "Devis";

  @override
  Widget build(BuildContext context) {
    final sized = MediaQuery.of(context).size;
    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (data) => Scaffold(
            key: scaffoldKey,
            appBar: headerBar(context, scaffoldKey, title, subTitle),
            drawer: const DrawerMenu(),
            floatingActionButton: FloatingActionButton.extended(
                label: const Text("Nouveau devis"),
                tooltip: "Devis",
                icon: const Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    constraints: BoxConstraints(
                      maxWidth: sized.width / 1.5,
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        height: sized.height / 2,
                        color: Colors.amber.shade100,
                        padding: const EdgeInsets.all(p20),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const TitleWidget(title: "Création du devis"),
                              const SizedBox(
                                height: p20,
                              ),
                              ResponsiveChildWidget(
                                  child1: titleWidget(),
                                  child2: priorityWidget()),
                              const SizedBox(
                                height: p20,
                              ),
                              BtnWidget(
                                  title: 'Crée maintenant',
                                  press: () {
                                    final form =
                                        controller.formKey.currentState!;
                                    if (form.validate()) {
                                      controller.submit();
                                      form.reset();
                                    }
                                  },
                                  isLoading: controller.isLoading)
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
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
                        child: TableDevis(
                            devisList: controller.devisList,
                            controller: controller))),
              ],
            )));
  }

  Widget titleWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.titleController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Intitulé',
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget priorityWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Priorité',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.priority,
        isExpanded: true,
        validator: (value) => value == null ? "Select Priorité" : null,
        items: controller.priorityList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.priority = value!;
          });
        },
      ),
    );
  }
}
