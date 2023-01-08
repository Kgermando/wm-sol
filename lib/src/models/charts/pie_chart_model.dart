class PieChartModel {
  final String departement;
  final int sum;

  PieChartModel({required this.departement, required this.sum});

  factory PieChartModel.fromSQL(List<dynamic> row) {
    return PieChartModel(
      departement: row[0],
      sum: row[1],
    );
  }

  factory PieChartModel.fromJson(Map<String, dynamic> json) {
    return PieChartModel(departement: json['departement'], sum: json['sum']);
  }

  Map<String, dynamic> toJson() {
    return {'departement': departement, 'sum': sum};
  }
}

class PieChartMaterielModel {
  final String statut;
  final int count;

  PieChartMaterielModel({required this.statut, required this.count});

  factory PieChartMaterielModel.fromSQL(List<dynamic> row) {
    return PieChartMaterielModel(
      statut: row[0],
      count: row[1],
    );
  }

  factory PieChartMaterielModel.fromJson(Map<String, dynamic> json) {
    return PieChartMaterielModel(statut: json['statut'], count: json['count']);
  }

  Map<String, dynamic> toJson() {
    return {'statut': statut, 'count': count};
  }
}

class PieChartEnguinModel {
  final String genre;
  final int count;

  PieChartEnguinModel({required this.genre, required this.count});

  factory PieChartEnguinModel.fromSQL(List<dynamic> row) {
    return PieChartEnguinModel(
      genre: row[0],
      count: row[1],
    );
  }

  factory PieChartEnguinModel.fromJson(Map<String, dynamic> json) {
    return PieChartEnguinModel(genre: json['genre'], count: json['count']);
  }

  Map<String, dynamic> toJson() {
    return {'genre': genre, 'count': count};
  }
}


class CountPieChartModel {
  final String categorie;
  final int count;

  CountPieChartModel({required this.categorie, required this.count});

  factory CountPieChartModel.fromSQL(List<dynamic> row) {
    return CountPieChartModel(
      categorie: row[0],
      count: row[1],
    );
  }

  factory CountPieChartModel.fromJson(Map<String, dynamic> json) {
    return CountPieChartModel(
        categorie: json['categorie'], count: json['count']);
  }

  Map<String, dynamic> toJson() {
    return {'categorie': categorie, 'count': count};
  }
}


class TypeFinancementPieChartModel {
  final String typeFinancement;
  final int count;

  TypeFinancementPieChartModel(
      {required this.typeFinancement, required this.count});

  factory TypeFinancementPieChartModel.fromSQL(List<dynamic> row) {
    return TypeFinancementPieChartModel(
      typeFinancement: row[0],
      count: row[1],
    );
  }

  factory TypeFinancementPieChartModel.fromJson(Map<String, dynamic> json) {
    return TypeFinancementPieChartModel(
        typeFinancement: json['type_financement'], count: json['count']);
  }

  Map<String, dynamic> toJson() {
    return {'type_financement': typeFinancement, 'count': count};
  }
}
