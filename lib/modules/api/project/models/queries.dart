import 'dart:convert';

class QueriesMyProjectModel {
  String slug;
  String title;
  String category;
  String type;

  QueriesMyProjectModel(
      {required this.slug,
      required this.title,
      required this.category,
      required this.type});

  factory QueriesMyProjectModel.fromJson(Map<String, dynamic> map) {
    return QueriesMyProjectModel(
      slug: map["project_slug"],
      title: map["project_title"],
      category: map["project_category"],
      type: map["project_type"],
    );
  }
}

List<QueriesMyProjectModel> queriesMyProjectModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<QueriesMyProjectModel>.from(
      data['data'].map((item) => QueriesMyProjectModel.fromJson(item)));
}

class QueriesMyProjectDetailModel {
  String slug;
  String title;
  String category;
  String type;
  String createdAt;
  String? desc;
  int totalEndpoint;

  QueriesMyProjectDetailModel({
    required this.slug,
    required this.title,
    required this.category,
    required this.type,
    required this.createdAt,
    required this.totalEndpoint,
    this.desc,
  });

  factory QueriesMyProjectDetailModel.fromJson(Map<String, dynamic> map) {
    return QueriesMyProjectDetailModel(
      slug: map["project_slug"],
      title: map["project_title"],
      category: map["project_category"],
      type: map["project_type"],
      createdAt: map["created_at"],
      desc: map["project_desc"],
      totalEndpoint: map["total_endpoint"],
    );
  }
}

List<QueriesMyProjectDetailModel> queriesMyProjectModelDetailFromJson(
    String jsonData) {
  final data = json.decode(jsonData);
  return List<QueriesMyProjectDetailModel>.from(
      data['data'].map((item) => QueriesMyProjectDetailModel.fromJson(item)));
}
