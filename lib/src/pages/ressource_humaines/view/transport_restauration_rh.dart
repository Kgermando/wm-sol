import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/transport_restauration/table_transport_rest.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class TransportRestaurationRH extends StatefulWidget {
  const TransportRestaurationRH({super.key});

  @override
  State<TransportRestaurationRH> createState() =>
      _TransportRestaurationRHState();
}

class _TransportRestaurationRHState extends State<TransportRestaurationRH> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";
  String subTitle = "Transports et Restaurations";

  @override
  Widget build(BuildContext context) {
    final TransportRestController controller = Get.put(TransportRestController());
    final sized = MediaQuery.of(context).size;
    return SafeArea(
      child: controller.obx(
        onLoading: loading(),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => Text(
            "Une erreur s'est produite $error veiller actualiser votre application. Merçi."),
        (data) => Scaffold(
          key: scaffoldKey,
          appBar: headerBar(context, scaffoldKey, title, subTitle),
          drawer: const DrawerMenu(),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text("Créer la liste"),
            tooltip: "Créer la liste pour ensuite ajouté des peronnes",
            icon: const Icon(Icons.group_add),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                constraints: BoxConstraints(
                  maxWidth: Responsive.isDesktop(context)
                      ? sized.width / 2
                      : sized.width,
                ),
                builder: (BuildContext context) {
                  return Container(
                    height: Responsive.isDesktop(context)
                        ? sized.height / 2
                        : sized.height,
                    color: Colors.amber.shade100,
                    padding: const EdgeInsets.all(p20),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[ 
                          Row(
                            children: [
                              Expanded(child: Text("Nommer la liste des personnels pour le paiement", style: Theme.of(context).textTheme.headlineSmall)),
                            ],
                          ),
                          const SizedBox(
                            height: p20,
                          ),
                          titleWidget(controller),
                          const SizedBox(
                            height: p20,
                          ),
                          BtnWidget(
                              title: 'Créer maintenant',
                              press: () { 
                                final form = controller.formKey.currentState!;
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
                      child: TableTransportRest(
                          transportRestList: controller.transportRestaurationList,
                          controller: controller))),
            ],
          ))),
    );
  }


  Widget titleWidget(TransportRestController controller) {
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
        maxLength: 30,
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
