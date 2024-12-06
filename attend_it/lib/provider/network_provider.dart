import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final networkProvider = Provider<NetworkService>((ref) {
  return NetworkService();
});

class NetworkService {
  Future<http.Response> postRequest(String url, Map<String, String> headers, dynamic body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    return response;
  }

  Future<http.Response> getRequest(String url) async {
    final response = await http.get(Uri.parse(url));
    return response;
  }
}
