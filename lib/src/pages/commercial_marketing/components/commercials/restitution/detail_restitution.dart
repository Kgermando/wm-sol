import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comm_maketing/restitution_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/restitution/restitution_pdf.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/restitution/restitution_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailRestitution extends StatefulWidget {
  const DetailRestitution({super.key, required this.restitutionModel});
  final RestitutionModel restitutionModel;

  @override
  State<DetailRestitution> createState() => _DetailRestitutionState();
}

class _DetailRestitutionState extends State<DetailRestitution> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial & Marketing";

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final RestitutionController controller = Get.put(RestitutionController());
    final ProfilController profilController = Get.put(ProfilController());

    return controller.obx(
        onLoading: loading(),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => Text(
            "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title,
                  widget.restitutionModel.idProduct),
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
                                          title: "Bon de livraison"),
                                      Column(
                                        children: [
                                          PrintWidget(
                                            tooltip:
                                                'Imprimer le document',
                                            onPressed: () async {
                                              await RestitutionPdf
                                                  .generate(widget.restitutionModel);
                                            },
                                          ),
                                          SelectableText(
                                              DateFormat(
                                                      "dd-MM-yyyy HH:mm")
                                                  .format(widget
                                                      .restitutionModel
                                                      .created),
                                              textAlign: TextAlign.start),
                                        ],
                                      )
                                    ],
                              ),
                                    dataWidget(controller, profilController),
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

  Widget dataWidget(RestitutionController controller,
      ProfilController profilController) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          if (widget.restitutionModel.succursale == profilController.user.succursale) 
          accRecepetion(controller),
          const SizedBox(height: p20),
          ResponsiveChildWidget(
            child1: Text('Produit :',
                        style:
                            bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.visible),
            child2: Text(widget.restitutionModel.idProduct,
                        style: bodyMedium, overflow: TextOverflow.visible)
          ),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
            child1: Text('Quantité restutué :',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis), 
            child2: Text(
              '${NumberFormat.decimalPattern('fr').format(double.parse(widget.restitutionModel.quantity))} ${widget.restitutionModel.unite}',
              style: bodyMedium,
              overflow: TextOverflow.ellipsis)
          ) 
        ],
      ),
    );
  }

  Widget accRecepetion(RestitutionController controller) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
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
                (widget.restitutionModel.accuseReception == 'false')
                    ? checkboxRead(controller)
                    : Text('OK',
                        style: Responsive.isDesktop(context)
                            ? const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.green)
                            : bodyText1!.copyWith(color: Colors.green)),
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

  checkboxRead(RestitutionController controller) {
    isChecked = widget.restitutionModel.accuseReception == 'true';
    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) { 
        setState(() {
          isChecked = value!;
          controller.receptionProduit(widget.restitutionModel);
        }); 
      },
    );
  }

}
