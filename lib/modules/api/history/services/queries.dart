import 'package:atepp/modules/api/history/models/queries.dart';
import 'package:atepp/modules/api/project/models/queries.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' show Client;

class QueriesHistoryService {
  final String baseUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<QueriesHistoryModel>> getListHistory(id) async {
    const token = '77|ehLvYJ7VsJ3VaN0nDP1rDxav7d8yQ7V01YB21ZZDe38c7aa5';
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(
      Uri.parse("$baseUrl/api/v1/project/response/$id"),
      headers: header,
    );

    if (response.statusCode == 200) {
      return queriesHistoryModelFromJson(response.body);
    } else {
      return [];
    }
  }
}
