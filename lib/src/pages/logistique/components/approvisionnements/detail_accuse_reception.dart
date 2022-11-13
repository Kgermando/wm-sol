import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/logistiques/approvision_reception_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvision_reception_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailAccuseReception extends StatefulWidget {
  const DetailAccuseReception(
      {super.key, required this.approvisionReceptionModel});
  final ApprovisionReceptionModel approvisionReceptionModel;

  @override
  State<DetailAccuseReception> createState() => _DetailAccuseReceptionState();
}

class _DetailAccuseReceptionState extends State<DetailAccuseReception> {
  final ApprovisionReceptionController controller = Get.find();
  final ProfilController profilController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title,
                  widget.approvisionReceptionModel.provision),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: p20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const TitleWidget(
                                                title: "Accusé reception"),
                                            Column(
                                              children: [
                                                SelectableText(
                                                    DateFormat(
                                                            "dd-MM-yyyy HH:mm")
                                                        .format(widget
                                                            .approvisionReceptionModel
                                                            .created),
                                                    textAlign: TextAlign.start),
                                              ],
                                            )
                                          ],
                                        ),
                                        dataWidget(),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )))
                ],
              ),
            ));
  }

  Widget dataWidget() {
    final bodyText2 = Theme.of(context).textTheme.bodyText2; 
 
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (departementList.contains(profilController.user.departement))
          accRecepetion(), 
          const SizedBox(height: p20),
          ResponsiveChildWidget(
              child1: Text('Département :',
                  style: Responsive.isDesktop(context)
                      ? const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20)
                      : bodyText2,
                  overflow: TextOverflow.visible),
              child2: Text(widget.approvisionReceptionModel.departement,
                  style: Responsive.isDesktop(context)
                      ? const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20)
                      : bodyText2,
                  overflow: TextOverflow.visible)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Produit :',
                  style: Responsive.isDesktop(context)
                      ? const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20)
                      : bodyText2,
                  overflow: TextOverflow.visible),
              child2: Text(widget.approvisionReceptionModel.provision,
                  style: Responsive.isDesktop(context)
                      ? const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20)
                      : bodyText2,
                  overflow: TextOverflow.visible)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Quantité :',
                  style: Responsive.isDesktop(context)
                      ? const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20)
                      : bodyText2,
                  overflow: TextOverflow.ellipsis),
              child2: Text(
                  '${NumberFormat.decimalPattern('fr').format(double.parse(widget.approvisionReceptionModel.quantity))} ${widget.approvisionReceptionModel.unite}',
                  style: Responsive.isDesktop(context)
                      ? const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20)
                      : bodyText2,
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget accRecepetion() {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
        var isCancelYear = widget.approvisionReceptionModel.createdReception.year ==
        DateTime.now().year;
    var isCancelMonth =
        widget.approvisionReceptionModel.createdReception.month ==
            DateTime.now().month;
    var isCancelDay = widget.approvisionReceptionModel.createdReception.day ==
        DateTime.now().day; 

    return Card(
      child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Accusé reception:',
                    style: Responsive.isDesktop(context)
                        ? const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16)
                        : bodyText1),
                const SizedBox(
                  width: 10.0,
                ),
                (widget.approvisionReceptionModel.accuseReception == 'false')
                    ? checkboxRead()
                    : Text('OK',
                        style: Responsive.isDesktop(context)
                            ? const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.green)
                            : bodyText1!.copyWith(color: Colors.green)),
                
                 const SizedBox(width: p20),
                if (widget.approvisionReceptionModel.accuseReception ==
                        'true' &&
                    isCancelYear &&
                    isCancelMonth &&
                    isCancelDay)
                  (widget.approvisionReceptionModel.livraisonAnnuler == 'false')
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              controller.submitLivraisonAnnuler(
                                  widget.approvisionReceptionModel);
                            });
                          },
                          child: const Text("Annuler la livraison"))
                      : const Text("Livraison annuler",
                          style: TextStyle(color: Colors.orange)),
              ],
            ),
          )),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.green;
  }

  checkboxRead() {
    bool isChecked = false;
    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          if (isChecked) {
            controller.submitReception(
                widget.approvisionReceptionModel, 'true');
          } else {
            controller.submitReception(
                widget.approvisionReceptionModel, 'false');
          }
        });
      },
    );
  }
}
