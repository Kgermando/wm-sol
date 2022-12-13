import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wm_solution/src/api/update/update_api.dart';
import 'package:wm_solution/src/api/upload_file_api.dart';
import 'package:wm_solution/src/models/update/update_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/utils/info_system.dart';

class UpdateController extends GetxController
    with StateMixin<List<UpdateModel>> {
  final UpdateVersionApi updateVersionApi = UpdateVersionApi();
  final ProfilController profilController = Get.find();

  List<UpdateModel> updateVersionList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController versionController = TextEditingController();
  TextEditingController motifController = TextEditingController();

  String isUpdateLocalVersion = InfoSystem().version();

  final _sumLocalVersion = 0.0.obs; // Local
  double get sumLocalVersion => _sumLocalVersion.value;

  final _sumVersionCloud = 0.0.obs; // Version mis en ligne
  double get sumVersionCloud => _sumVersionCloud.value;

  bool downloading = false;
  final _progressString = '0'.obs;
  String get progressString => _progressString.value;

  final _isUploading = false.obs;
  bool get isUploading => _isUploading.value;
  final _isUploadingDone = false.obs;
  bool get isUploadingDone => _isUploadingDone.value;

  String? uploadedFileUrl;

  void uploadFile(String file) async {
    _isUploading.value = true;
    await FileApi().uploadFiled(file).then((value) {
      uploadedFileUrl = value;
      _isUploading.value = false;
      _isUploadingDone.value = true;
    });
  }

  Future<void> downloadNetworkSoftware({required String url}) async {
    Dio dio = Dio();
    try {
      var dir = await getDownloadsDirectory();
      final name = url.split('/').last;
      final fileName = '${dir!.path}/$name';
      Get.snackbar("Téléchargement en cours", "Patientez svp...",
          backgroundColor: Colors.blue,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
      await dio.download(url, fileName, onReceiveProgress: (received, total) {
        downloading = true;
        _progressString.value =
            "${((received / total) * 100).toStringAsFixed(0)}%";
        update();
      }).then((value) {
        Get.snackbar("Téléchargement réussi!", " ",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        // OpenFile.open(fileName);
      });
    } catch (e) {
      Get.snackbar("Erreur de Téléchargement", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

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

  void clear() {
    versionController.clear();
    motifController.clear();
  }

  void getList() async {
    await updateVersionApi.getAllData().then((response) {
      updateVersionList.clear();
      updateVersionList.addAll(response);

      if (updateVersionList.isNotEmpty) {
        // // Version actuel
        var isVersion = isUpdateLocalVersion.split('.');
        for (var e in isVersion) {
          _sumLocalVersion.value += double.parse(e); 
        }

        // Version Cloud
        var isVersionCloud = updateVersionList.first.version.split('.');
        for (var e in isVersionCloud) {
          _sumVersionCloud.value += double.parse(e); 
        }
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
        isActive: 'true',
        motif: motifController.text,
      );
      await updateVersionApi.insertData(dataItem).then((value) {
        clear();
        updateVersionList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
            "Le document a bien été sauvegadé",
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
