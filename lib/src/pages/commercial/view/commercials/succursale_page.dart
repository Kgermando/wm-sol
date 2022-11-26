import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial/components/succursale/table_succursale.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/succursale/succursale_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class SuccursalePage extends StatefulWidget {
  const SuccursalePage({super.key});

  @override
  State<SuccursalePage> createState() => _SuccursalePageState();
}

class _SuccursalePageState extends State<SuccursalePage> {
  final SuccursaleController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";
  String subTitle = "Succursales";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title, subTitle),
              drawer: const DrawerMenu(),
              floatingActionButton: FloatingActionButton.extended(
                  label: const Text("Ajouter une succursale"),
                  tooltip: "Nouveau succursale",
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      showModalBottomSheet<void>(
                        context: context,
                        // constraints: BoxConstraints(
                        //   maxWidth: MediaQuery.of(context).size.width /4,
                        // ),
                        builder: (BuildContext context) {
                          return Container(
                              // color: Colors.amber.shade100,
                              padding: const EdgeInsets.all(p20),
                              child: Form(
                                key: controller.formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        TitleWidget(title: "Ajout Succursale")
                                      ],
                                    ),
                                    const SizedBox(
                                      height: p20,
                                    ),
                                    ResponsiveChildWidget(
                                        child1: nameWidget(),
                                        child2: provinceWidget()),
                                    // nameWidget(),
                                    // provinceWidget(),
                                    adresseWidget(),
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
                                            controller.submit();
                                            form.reset();
                                          }
                                        })
                                  ],
                                ),
                              ));
                        },
                      );
                    });

                    // Get.toNamed(ComRoutes.comSuccursaleAdd);
                  }),
              body: controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (data) => Row(
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
                          child: TableSuccursale(
                              succursaleList: controller.succursaleList,
                              controller: controller))),
                ],
              )) );
    
     
  }

  Widget nameWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.nameController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom de la succursale',
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

  Widget adresseWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          maxLines: 3,
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

  Widget provinceWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Province',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.province,
        isExpanded: true,
        items: controller.provinceList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select province" : null,
        onChanged: (value) {
          setState(() {
            controller.province = value!;
          });
        },
      ),
    );
  }
}
