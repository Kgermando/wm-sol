import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/stock_global/stock_global_controller.dart';
import 'package:wm_solution/src/utils/regex.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class AddStockGlobal extends StatefulWidget {
  const AddStockGlobal({super.key});

  @override
  State<AddStockGlobal> createState() => _AddStockGlobalState();
}

class _AddStockGlobalState extends State<AddStockGlobal> {
  final StockGlobalController controller = Get.put(StockGlobalController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial & Marketing";
  String subTitle = "Ajout stock global";

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: p20),
                                    child: Form(
                                      key: controller.formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TitleWidget(
                                              title: "Ajout stock global"),
                                          const SizedBox(
                                            height: p10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text('Mode achat :',
                                                    textAlign: TextAlign.start,
                                                    style: bodyMedium!.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              const SizedBox(
                                                width: p10,
                                              ),
                                              Expanded(child: modeAchatField())
                                            ],
                                          ),
                                          idProductField(),
                                          ResponsiveChildWidget(
                                              child1: quantityAchatField(),
                                              child2: priceAchatUnitField()),
                                          ResponsiveChildWidget(
                                              child1: prixVenteField(),
                                              child2: tvaField()),
                                          const SizedBox(
                                            height: p20,
                                          ),
                                          BtnWidget(
                                              title: 'Soumettre',
                                              isLoading: controller.isLoading,
                                              press: () {
                                                final form = controller
                                                    .formKey.currentState!;
                                                if (form.validate()) {
                                                  controller.submit();
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
            ));
  }

  Widget modeAchatField() {
    return Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        child: FlutterSwitch(
          width: Responsive.isDesktop(context) ? 225.0 : 150,
          height: 55.0,
          inactiveColor: Colors.red,
          valueFontSize: 25.0,
          toggleSize: 45.0,
          value: controller.modeAchat,
          borderRadius: 30.0,
          padding: 8.0,
          showOnOff: true,
          activeText: 'PAYE',
          inactiveText: 'NON PAYE',
          onToggle: (val) {
            setState(() {
              controller.modeAchat = val;
              if (controller.modeAchat == true) {
                controller.modeAchatBool = "true";
              } else {
                controller.modeAchatBool = "false";
              }
            });
          },
        ));
  }

  Widget idProductField() {
    List<String> prod = [];
    List<String> stocks = [];
    List<String> catList = [];

    prod =
        controller.idProductDropdown.map((e) => e.idProduct).toSet().toList();
    stocks =
        controller.stockGlobalList.map((e) => e.idProduct).toSet().toList();

    catList = prod.toSet().difference(stocks.toSet()).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Identifiant du produit',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.idProduct,
        isExpanded: true,
        // style: const TextStyle(color: Colors.deepPurple),
        items: catList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (produit) {
          setState(() {
            controller.idProduct = produit;
          });
        },
      ),
    );
  }

  Widget quantityAchatField() {
    return Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        child: TextFormField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            labelText: 'Quantités entrant',
            labelStyle: const TextStyle(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'La Quantité total est obligatoire';
            } else if (RegExpIsValide().isValideVente.hasMatch(value!)) {
              return 'chiffres obligatoire';
            } else {
              return null;
            }
          },
          onChanged: (value) => setState(() {
            controller.quantityAchat = value.trim();
          }),
        ));
  }

  Widget priceAchatUnitField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        decoration: InputDecoration(
          labelText: 'Prix d\'achat unitaire',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'Le Prix total d\'achat est obligatoire';
          } else if (RegExpIsValide().isValideVente.hasMatch(value!)) {
            return 'chiffres obligatoire';
          } else {
            return null;
          }
        },
        onChanged: (value) => setState(() {
          controller.priceAchatUnit = value.trim();
        }),
      ),
    );
  }

  Widget prixVenteField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        decoration: InputDecoration(
          labelText: 'Prix de vente unitaire',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'Le Prix de vente unitaires est obligatoire';
          } else if (RegExpIsValide().isValideVente.hasMatch(value!)) {
            return 'chiffres obligatoire';
          } else {
            return null;
          }
        },
        onChanged: (value) => setState(() {
          controller.prixVenteUnit = (value == "") ? 1 : double.parse(value);
        }),
      ),
    );
  }

  Widget tvaField() {
    return ResponsiveChildWidget(
        child1: Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          child: TextFormField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              labelText: 'TVA en %',
              // hintText: 'Mettez "1" si vide',
              labelStyle: const TextStyle(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            validator: (value) {
              if (RegExpIsValide().isValideVente.hasMatch(value!)) {
                return 'chiffres obligatoire';
              } else {
                return null;
              }
            },
            onChanged: (value) => setState(() {
              controller.tva = (value == "") ? 1 : double.parse(value);
            }),
          ),
        ),
        child2: tvaValeur());
  }

  double? pavTVA;

  tvaValeur() {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    var pvau = controller.prixVenteUnit * controller.tva / 100;
    pavTVA = controller.prixVenteUnit + pvau;
    return Container(
        margin: const EdgeInsets.only(left: 10.0, bottom: 20.0),
        child: Text('PVU: ${pavTVA!.toStringAsFixed(2)} \$', style: bodyText1));
  }
}
