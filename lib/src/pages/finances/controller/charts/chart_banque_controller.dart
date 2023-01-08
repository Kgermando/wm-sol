import 'package:get/get.dart';
import 'package:wm_solution/src/api/finances/banque_api.dart';
import 'package:wm_solution/src/models/charts/chart_multi.dart';

class ChartBanqueController extends GetxController
    with StateMixin<List<ChartFinanceModel>> {
  final BanqueApi banqueApi = BanqueApi();

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
    await banqueApi.getAllDataChart().then((response) {
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
