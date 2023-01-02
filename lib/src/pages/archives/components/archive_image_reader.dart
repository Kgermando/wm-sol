import 'package:flutter/material.dart'; 
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart'; 

class ArchiveImageReader extends StatefulWidget {
  const ArchiveImageReader({super.key, required this.url});
  final String url;

  @override
  State<ArchiveImageReader> createState() => _ArchiveImageReaderState();
}

class _ArchiveImageReaderState extends State<ArchiveImageReader> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Archive"; 
 

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(
            context, scaffoldKey, title, 'View'),
        drawer: const DrawerMenu(),
        body: Row(
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenu())),
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.only(
                    top: p20, bottom: p8, right: p20, left: p20),
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                     Image.network(widget.url)
                  ],
                ),
              ))
          ], 
      ));
  }
}
