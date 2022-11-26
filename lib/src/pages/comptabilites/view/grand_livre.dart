import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comptabilites/balance_model.dart';  
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_controller.dart'; 
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class GrandLivre extends StatefulWidget {
  const GrandLivre({super.key});

  @override
  State<GrandLivre> createState() => _GrandLivreState();
}

class _GrandLivreState extends State<GrandLivre> {
  final BalanceController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilités";
  String subTitle = "Grand Livre";

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController compteController = TextEditingController();

  @override
  void dispose() {
    compteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenu(),
        body: controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (state) => Row(
            children: [
              Visibility(
                  visible: !Responsive.isMobile(context),
                  child: const Expanded(flex: 1, child: DrawerMenu())),
              Expanded(
                  flex: 5,
                  child: Card(
                    child: Container(
                        margin: const EdgeInsets.all(p20),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: pageView(state!)),
                  )),
            ],
          )));
  }

  Widget pageView(List<BalanceModel> data) {
    return Container(
      padding: const EdgeInsets.all(p20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    color: Colors.green,
                    tooltip: "Actualiser la page",
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ComptabiliteRoutes.comptabiliteGrandLivre);
                    },
                    icon: const Icon(Icons.refresh)),
              ],
            ),
            const SizedBox(height: p10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.book, size: p50, color: Colors.red),
                        TitleWidget(title: "Grand Livre"),
                      ],
                    ),
                    const SizedBox(height: p20),
                    Responsive.isMobile(context)
                        ? Column(
                            children: [compteWidget(data), buttonWidget(data)])
                        : Row(children: [
                            SizedBox(width: 500.0, child: compteWidget(data)),
                            const SizedBox(width: p10),
                            SizedBox(
                                width: 150.0,
                                height: 70,
                                child: buttonWidget(data))
                          ]),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget compteWidget(List<BalanceModel> data) { 
    List<String> suggestionList =
        data.map((e) => e.comptes).toSet().toList(); 
 

    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: EasyAutocomplete(
          controller: compteController,
          
          decoration: InputDecoration(
            labelText: 'Compte',
            labelStyle: const TextStyle(),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
            contentPadding: const EdgeInsets.only(left: 5.0),
          ),
          keyboardType: TextInputType.text,
          suggestions: suggestionList,
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget buttonWidget(List<BalanceModel> data) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: ElevatedButton.icon(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () {
            final form = formKey.currentState!;
            if (form.validate()) {
              searchKey(data);
              form.reset();
            }
          },
          icon: const Icon(Icons.search, color: Colors.white),
          label: Text("Recherche",
              style: bodyMedium!.copyWith(color: Colors.white))),
    );
  }

  void searchKey(List<BalanceModel> data) {  
    final search = data
        .where((element) => element.comptes == compteController.text)
        .toList();
    Get.toNamed(ComptabiliteRoutes.comptabiliteGrandLivreSearch,
        arguments: search);
  }
}
