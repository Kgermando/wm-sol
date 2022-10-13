import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/archives/archive_api.dart';
import 'package:wm_solution/src/models/archive/archive_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/utils/dropdown.dart';
import 'package:wm_solution/src/widgets/file_uploader.dart';
import 'package:dospace/dospace.dart' as dospace;

class ArchiveController extends GetxController
    with StateMixin<List<ArchiveModel>> {
  final ArchiveApi archiveApi = ArchiveApi();
  final ProfilController profilController = Get.find();

  var archiveList = <ArchiveModel>[].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

    final List<String> departementList = Dropdown().departement;

  TextEditingController nomDocumentController = TextEditingController();
  String? departement;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController fichierController = TextEditingController();

  final _isUploading = false.obs;
  bool get isUploading => _isUploading.value;
  final _isUploadingDone = false.obs;
  bool get isUploadingDone => _isUploadingDone.value;
 
  String? uploadedFileUrl;

  void pdfUpload(File pdfFile) async {
    String projectName = "fokad-spaces";
    String region = "sfo3";
    String folderName = "archives";
    String? pdfFileName;

    String extension = 'pdf';
    pdfFileName = "${DateTime.now().millisecondsSinceEpoch}.$extension";

    uploadedFileUrl =
        "https://$projectName.$region.digitaloceanspaces.com/$folderName/$pdfFileName";
    // print('url: $uploadedFileUrl');
    _isUploading.value = true;
    dospace.Bucket bucketpdf = FileUploader().spaces.bucket('fokad-spaces');
    String? etagpdf = await bucketpdf.uploadFile('$folderName/$pdfFileName',
        pdfFile, 'application/pdf', dospace.Permissions.public);
    _isUploading.value = false;
    _isUploadingDone.value = false; 
    if (kDebugMode) {
      print('upload: $etagpdf');
      print('done');
    }
  }



  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    nomDocumentController.dispose();
    descriptionController.dispose();
    fichierController.dispose();

    super.dispose();
  }


  void getList() async {
    await archiveApi.getAllData().then((response) {
      archiveList.assignAll(response); 
      change(archiveList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await archiveApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await archiveApi.deleteData(id).then((value) {
        archiveList.clear();
        getList();
        // Get.back();
        Get.snackbar("Supprimé avec succès!", "Cet élément a bien été supprimé",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }


  void submit(ArchiveFolderModel data) async {
    try {
      _isLoading.value = true;
       final archiveModel = ArchiveModel(
          departement: data.departement,
          folderName: data.folderName,
          nomDocument: nomDocumentController.text,
          description: descriptionController.text,
          fichier: (uploadedFileUrl == '') ? '-' : uploadedFileUrl.toString(),
          signature: profilController.user.matricule,
          created: DateTime.now());
      await archiveApi.insertData(archiveModel).then((value) {
        archiveList.clear();
        getList();
        Get.back();
        Get.snackbar("Archivage effectuée avec succès!",
            "Le document a bien été sauvegader",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void updateData(ArchiveModel data) async {
    try {
      _isLoading.value = true;
      final archiveModel = ArchiveModel(
          departement: data.departement,
          folderName: data.folderName,
          nomDocument: (nomDocumentController.text == "") 
            ? nomDocumentController.text : data.nomDocument,
          description: (descriptionController.text == "")
              ? descriptionController.text
              : data.description,
          fichier: (uploadedFileUrl == '') ? '-' : uploadedFileUrl.toString(),
          signature: profilController.user.matricule,
          created: DateTime.now());
      await archiveApi.updateData(archiveModel).then((value) {
        archiveList.clear();
        getList();
        Get.back();
        Get.snackbar("Modification de l'Archive effectuée avec succès!",
            "Le document a bien été sauvegader",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}