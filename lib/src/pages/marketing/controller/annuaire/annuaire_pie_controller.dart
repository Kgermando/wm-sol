import 'package:get/get.dart';
import 'package:wm_solution/src/api/marketing/annuaire_api.dart';
import 'package:wm_solution/src/models/charts/pie_chart_model.dart';

class AnnuairePieController extends GetxController
    with StateMixin<List<CountPieChartModel>> {
  final AnnuaireApi annuaireApi = AnnuaireApi();

  List<CountPieChartModel> annuairePieList = [];

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  void getList() async {
    await annuaireApi.getChartPie().then((response) {
      annuairePieList.clear();
      annuairePieList.addAll(response);
      change(annuairePieList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}
