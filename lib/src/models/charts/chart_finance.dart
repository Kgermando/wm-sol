class ChartFinanceModel {
  final String name;
  final double depot;
  final double retrait;

  ChartFinanceModel(
      {required this.name, required this.depot, required this.retrait});

  factory ChartFinanceModel.fromSQL(List<dynamic> row) {
    return ChartFinanceModel(
      name: row[0],
      depot: row[1],
      retrait: row[2],
    );
  }

  factory ChartFinanceModel.fromJson(Map<String, dynamic> json) {
    return ChartFinanceModel(
      name: json['name'], depot: json['depot'], retrait: json['retrait']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'depot': depot, 'retrait': retrait};
  }
}
