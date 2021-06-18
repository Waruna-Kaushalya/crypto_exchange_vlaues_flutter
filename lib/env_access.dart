import 'package:flutter_dotenv/flutter_dotenv.dart';

class AccessEnv {
  var apiKey;

  String getApiKey() {
    try {
      apiKey = dotenv.env['API_KEY'];

      return apiKey;
    } catch (e) {
      print(e);
    }
    return apiKey;
  }
}
