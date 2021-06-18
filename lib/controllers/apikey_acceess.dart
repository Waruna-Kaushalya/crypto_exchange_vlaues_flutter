import 'package:crypto_exchange/env_access.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AccessApiData {
  Future<dynamic> fetchApi(String coin, String baseCoin) async {
    AccessEnv av = AccessEnv();

    var url =
        'https://rest.coinapi.io/v1/exchangerate/$baseCoin/$coin?apikey=${av.getApiKey()}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
