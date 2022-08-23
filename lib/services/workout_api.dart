import 'package:http/http.dart' as http;
import 'dart:convert';

class WorkoutApi {
  static const String baseUrl =
      'https://exercises-by-api-ninjas.p.rapidapi.com/v1/exercises';
  static const String apiKey =
      '88e6e1a3cdmshde82ace8b4e5613p110cabjsn58d14ad01a23';
  void getData() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'X-RapidAPI-Key':
              '88e6e1a3cdmshde82ace8b4e5613p110cabjsn58d14ad01a23',
          'X-RapidAPI-Host': 'exercises-by-api-ninjas.p.rapidapi.com'
        },
      );
      // final dataResponse = json.decode(response.body);
      print(json.decode(response.body));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
