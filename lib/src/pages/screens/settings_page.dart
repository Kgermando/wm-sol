import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart'; 
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/utils/dropdown.dart';
import 'package:wm_solution/src/utils/info_system.dart';
import 'package:wm_solution/src/utils/licence_wm.dart';
import 'package:wm_solution/src/utils/monnaie_dropdown.dart';
import 'package:wm_solution/src/widgets/change_theme_button_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Settings";
  String subTitle = InfoSystem().version();

  List<String> langues = Dropdown().langues;
  List<String> deviseList = MonnaieDropDown().devises;

  String? devise;
  String? langue;
  String? formatImprimante;

  @override
  void initState() {
    super.initState();
    setState(() {
      langues.first;
    });
    LicenceWM().initMyLibrary();
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
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ListSettings(
                                icon: Icons.theater_comedy,
                                title: 'Thèmes',
                                options: ChangeThemeButtonWidget()),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListSettings(
                                icon: Icons.language,
                                title: 'Langues',
                                options: langueWidget(context)),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListSettings(
                                icon: Icons.monetization_on,
                                title: 'Devise',
                                options: deviseWidget(context)),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListSettings(
                                icon: Icons.print,
                                title: 'Format imprimante',
                                options: formatImprimanteWidget(context)),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListSettings(
                                icon: Icons.apps_rounded,
                                title: 'Version Plateform',
                                options: getVersionField(context)),
                          ),
                        ),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  Widget langueWidget(BuildContext context) {
    return DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelStyle: TextStyle(),
          contentPadding: EdgeInsets.only(left: 5.0),
        ),
        value: langues.first,
        isExpanded: true,
        items: langues.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            langue = value;
          });
        });
  }

  Widget deviseWidget(BuildContext context) {
    final MonnaieStorage controller = Get.put(MonnaieStorage());

    return DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Devise',
          labelStyle: TextStyle(),
          contentPadding: EdgeInsets.only(left: 5.0),
        ),
        value: devise,
        isExpanded: true,
        items: deviseList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            devise = value; 
            if (devise == "\$") {

            } else if (devise == "€") {

            } else if (devise == "CDF") {

            } else if (devise == "FCFA") {
              
            }
          });
        });
  }

  Widget formatImprimanteWidget(BuildContext context) {
    List<String> formatList = ["A4", "A6"];
    return DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelStyle: TextStyle(),
          contentPadding: EdgeInsets.only(left: 5.0),
        ),
        value: formatImprimante,
        isExpanded: true,
        items: formatList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            formatImprimante = value;
            GetStorage box = GetStorage();

            if (formatImprimante == 'A4') {
              box.remove("printer");
              box.write("printer", formatImprimante);
            }
            if (formatImprimante == 'A6') {
              box.remove("printer");
              box.write("printer", formatImprimante);
            }
          });
        });
  }

  Widget getVersionField(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return SizedBox(
      height: 200,
      width: 200,
      child: TextButton(
          child: Text(InfoSystem().version(), style: headline6),
          onPressed: () => showAboutDialog(
                  context: context,
                  applicationName: InfoSystem().name(),
                  applicationIcon: Image.asset(
                    InfoSystem().logoIcon(),
                    width: 50,
                    height: 50,
                  ),
                  applicationVersion: InfoSystem().version(),
                  children: [
                    Text(
                        "Work Management est une solution numerique \n pour les grandes, moyennes et petites entreprises \n ainsi que l'administration public. ",
                        textAlign: TextAlign.justify,
                        style: bodyMedium),
                    const SizedBox(height: p20),
                    Text("® Copyright Eventdrc Technology",
                        style:
                            bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                  ])

          // showDialog<String>(
          //   context: context,
          //   builder: (BuildContext context) => AlertDialog(
          //       title: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           ,
          //           const SizedBox(height: p20),
          //           Text(),
          //         ],
          //       ),
          //       content:
          //           ),
          // ),
          ),
    );
  }
}

class ListSettings extends StatelessWidget {
  const ListSettings(
      {Key? key,
      required this.icon,
      required this.title,
      required this.options})
      : super(key: key);

  final IconData icon;
  final String title;
  final Widget options;

  @override
  Widget build(BuildContext context) {
    final headline5 = Theme.of(context).textTheme.headline5;
    final headline6 = Theme.of(context).textTheme.headline6;
    return ListTile(
      leading: Icon(icon),
      title: Text(title,
          style: Responsive.isDesktop(context) ? headline5 : headline6),
      trailing: SizedBox(width: 100, child: options),
    );
  }
}
