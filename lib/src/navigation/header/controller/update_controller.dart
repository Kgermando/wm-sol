import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/update/update_api.dart';
import 'package:wm_solution/src/models/update/update_model.dart';
import 'package:wm_solution/src/utils/info_system.dart'; 

class UpdateController extends GetxController
    with StateMixin<List<UpdateModel>> {
  final UpdateVersionApi updateVersionApi = UpdateVersionApi(); 

  var updateVersionList = <UpdateModel>[].obs;

  String isUpdateVersion = InfoSystem().version();
  double sumVersion = 0.0;
  double sumVersionCloud = 0.0; // Version mis en ligne

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController versionController = TextEditingController();
  TextEditingController motifController = TextEditingController();
  

  
  bool isUploading = false;
  bool isUploadingDone = false;
  String? uploadedFileUrl;


  @override
  void onInit() {
    super.onInit();
    getList();
  }

    @override
  void dispose() {
    versionController.dispose();
    motifController.dispose();
    super.dispose();
  }


  // void _pdfUpload(File file) async {
  //   String projectName = "fokad-spaces";
  //   String region = "sfo3";
  //   String folderName = "update";
  //   String? fileName;

  //   String extension = 'msix';
  //   fileName = "${DateTime.now().microsecondsSinceEpoch}.$extension";

  //   uploadedFileUrl =
  //       "https://$projectName.$region.digitaloceanspaces.com/$folderName/$fileName";
  //   // print('url: $uploadedFileUrl');
  //   setState(() {
  //     isUploading = true;
  //   });
  //   dospace.Bucket bucketpdf = FileUploader().spaces.bucket('fokad-spaces');
  //   String? etagpdf = await bucketpdf.uploadFile('$folderName/$fileName', file,
  //       'application/file', dospace.Permissions.public);
  //   setState(() {
  //     isUploading = false;
  //     isUploadingDone = true;
  //   });
  //   if (kDebugMode) {
  //     print('upload: $etagpdf');
  //     print('done');
  //   }
  // }

  

  void getList() async {
    await updateVersionApi.getAllData().then((response) {
      updateVersionList.assignAll(response.where((element) => element.isActive == "true").toList()); 
      // Version actuel
      var isVersion = isUpdateVersion.split('.');
      for (var e in isVersion) {
        sumVersion += double.parse(e);
      }

      // Version Cloud
      var isVersionCloud = updateVersionList.last.version.split('.');
      for (var e in isVersionCloud) {
        sumVersionCloud += double.parse(e);
      }
      change(updateVersionList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await updateVersionApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await updateVersionApi.deleteData(id).then((value) {
        updateVersionList.clear();
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

  void submit() async {
    try {
      _isLoading.value = true;
      final dataItem = UpdateModel(
        version: versionController.text,
        urlUpdate: (uploadedFileUrl == '') ? '-' : uploadedFileUrl.toString(),
        created: DateTime.now(),
        isActive: 'false',
        motif: motifController.text,
      );
      await updateVersionApi.insertData(dataItem).then((value) {
        updateVersionList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
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

  void submitUpdate(UpdateModel data) async {
    try {
      _isLoading.value = true;
      _isLoading.value = true;
      final dataItem = UpdateModel(
        version: versionController.text,
        urlUpdate: (uploadedFileUrl == '') ? data.urlUpdate : uploadedFileUrl.toString(),
        created: data.created,
        isActive: 'false',
        motif: motifController.text,
      );
      await updateVersionApi.updateData(dataItem).then((value) {
        updateVersionList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
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
