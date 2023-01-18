class CourbeBudgetModel {
  final String created;
  final double sum;

  CourbeBudgetModel({required this.created, required this.sum});

  factory CourbeBudgetModel.fromSQL(List<dynamic> row) {
    return CourbeBudgetModel(
      created: row[0],
      sum: row[1],
    );
  }

  factory CourbeBudgetModel.fromJson(Map<String, dynamic> json) {
    return CourbeBudgetModel(
      created: json['created'],
      sum: json['sum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'created': created, 'sum': sum};
  }
}
