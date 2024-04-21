import 'dart:convert';

class QueriesStatsModel {
  String ctx;
  int total;

  QueriesStatsModel({required this.ctx, required this.total});

  factory QueriesStatsModel.fromJson(Map<String, dynamic> map) {
    return QueriesStatsModel(
      ctx: map["context"],
      total: map["total"],
    );
  }
}

List<QueriesStatsModel> queriesStatsModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<QueriesStatsModel>.from(
      data['data'].map((item) => QueriesStatsModel.fromJson(item)));
}
