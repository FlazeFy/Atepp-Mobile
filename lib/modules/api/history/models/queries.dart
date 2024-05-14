import 'dart:convert';
import 'dart:ffi';

class QueriesHistoryModel {
  String id;
  String resStatus;
  String endpointName;
  String resTime;
  String resMethod;
  String resEnv;
  String createdAt;

  QueriesHistoryModel(
      {required this.id,
      required this.resStatus,
      required this.endpointName,
      required this.resTime,
      required this.resMethod,
      required this.resEnv,
      required this.createdAt});

  factory QueriesHistoryModel.fromJson(Map<dynamic, dynamic> map) {
    return QueriesHistoryModel(
      id: map["id"],
      resStatus: map["response_status"].toString(),
      endpointName: map["endpoint_name"],
      resTime: map["response_time"].toString(),
      resMethod: map["response_method"],
      resEnv: map["response_env"],
      createdAt: map["created_at"],
    );
  }
}

List<QueriesHistoryModel> queriesHistoryModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<QueriesHistoryModel>.from(
      data['data'].map((item) => QueriesHistoryModel.fromJson(item)));
}
