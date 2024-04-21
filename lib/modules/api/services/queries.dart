import 'package:atepp/modules/api/models/queries.dart';
import 'package:http/http.dart' show Client;

class QueriesStatsService {
  final String baseUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<QueriesStatsModel>> getStatsPerf() async {
    const token = 'Bearer 77|ehLvYJ7VsJ3VaN0nDP1rDxav7d8yQ7V01YB21ZZDe38c7aa5';
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client.get(
        Uri.parse("$baseUrl/api/v1/stats/response/performance"),
        headers: header);
    if (response.statusCode == 200) {
      return queriesStatsModelFromJson(response.body);
    } else {
      return [];
    }
  }
}
