
import 'package:get/get.dart';
import 'package:wm_solution/src/api/finances/fin_exterieur_api.dart'; 
import 'package:wm_solution/src/models/charts/chart_multi.dart'; 

class ChartFinExterieurController extends GetxController
    with StateMixin<List<ChartFinanceModel>> {
  final FinExterieurApi finExterieurApi = FinExterieurApi(); 

  var chartList = <ChartFinanceModel>[].obs;
 
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
 

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  
  void getList() async {
    _isLoading.value = true;
    await finExterieurApi.getAllDataChart().then((response) {
      chartList.clear();
      chartList.assignAll(response);
      change(chartList, status: RxStatus.success());
      _isLoading.value = false;
    }, onError: (err) {
      _isLoading.value = false;
      change(null, status: RxStatus.error(err.toString()));
    });
  } 
  
}
