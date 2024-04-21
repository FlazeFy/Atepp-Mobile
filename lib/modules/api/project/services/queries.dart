import 'package:atepp/modules/api/project/models/queries.dart';
import 'package:http/http.dart' show Client;

class QueriesProjectService {
  final String baseUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<QueriesMyProjectModel>> getListProject() async {
    const token = 'Bearer 77|ehLvYJ7VsJ3VaN0nDP1rDxav7d8yQ7V01YB21ZZDe38c7aa5';
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response =
        await client.get(Uri.parse("$baseUrl/api/v1/project"), headers: header);
    if (response.statusCode == 200) {
      return queriesMyProjectModelFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<List<QueriesMyProjectDetailModel>> getMyProject() async {
    const token = 'Bearer 77|ehLvYJ7VsJ3VaN0nDP1rDxav7d8yQ7V01YB21ZZDe38c7aa5';
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final response = await client
        .get(Uri.parse("$baseUrl/api/v1/project/detail"), headers: header);
    if (response.statusCode == 200) {
      return queriesMyProjectModelDetailFromJson(response.body);
    } else {
      return [];
    }
  }
}
