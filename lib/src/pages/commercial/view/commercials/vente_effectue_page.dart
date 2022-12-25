import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/commercial/vente_cart_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/produit_model/produit_model_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/vente_effectue/ventes_effectue_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class VenteEffectue extends StatefulWidget {
  const VenteEffectue({super.key});

  @override
  State<VenteEffectue> createState() => _VenteEffectueState();
}

class _VenteEffectueState extends State<VenteEffectue> {
  final VenteEffectueController controller = Get.find();
  final ProduitModelController produitModelController =
      Get.put(ProduitModelController());
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";
  String subTitle = "Ventes effectués";

  bool isOpen = false;

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
              child: controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (state) => SingleChildScrollView(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TitleWidget(title: "Vos ventes"),
                          IconButton(
                              onPressed: () {
                                controller.getList();
                              },
                              icon: const Icon(Icons.refresh,
                                  color: Colors.green))
                        ],
                      ),
                      treeView(state!)
                    ],
                  )))) )
                ],
              )  
    );
  }

  Widget treeView(List<VenteCartModel> state) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Column(
      children: produitModelController.produitModelList
          .map((e) {
            List<VenteCartModel> ventList = state
                .where((element) => element.idProductCart == e.idProduct)
                .toList();

            String count =
                (ventList.length > 9999) ? "9999+" : "${ventList.length}";
            return Card(
              child: ExpansionTile(
                leading: Badge(
                  badgeContent: Padding(
                    padding: const EdgeInsets.all(p10),
                    child: Text(count,
                        style: bodySmall!.copyWith(color: Colors.white)),
                  ),
                  showBadge: (ventList.isNotEmpty),
                ),
                title: Text(e.idProduct),
                onExpansionChanged: (val) {
                  setState(() {
                    isOpen = !val;
                  });
                },
                children: List.generate(ventList.length, (index) {
                  var vente = ventList[index];
                  double unitaire = double.parse(vente.priceTotalCart) /
                      double.parse(vente.quantityCart);
                  var countItem =  index + 1;
                  return ListTile(
                    onTap: () => Get.toNamed(ComRoutes.comVenteEffectueDetail, arguments: vente),
                    leading: Text("$countItem.",
                        style: bodyMedium),
                    title: Text(
                        "${NumberFormat.decimalPattern('fr').format(double.parse(vente.quantityCart))} ${vente.unite} x ${NumberFormat.decimalPattern('fr').format(unitaire)} = ${NumberFormat.decimalPattern('fr').format(double.parse(vente.priceTotalCart))} ${monnaieStorage.monney}",
                        style: bodyMedium),
                    subtitle: Text(vente.succursale, style: bodyMedium!.copyWith(color: mainColor)),
                    trailing: Text(
                        DateFormat("dd-MM-yy HH:mm").format(vente.created),
                        style: bodyMedium),
                  );
                }),
              ),
            );
          })
          .toSet()
          .toList(),
    );
  }
}
