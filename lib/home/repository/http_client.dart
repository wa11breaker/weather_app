import 'package:http/http.dart' show Client, Response;

class HttpClient {
  HttpClient({Client? client}) : _client = client ?? Client();

  final Client _client;

  Future<Response> get(String url) async {
    final res = await _client.get(Uri.parse(url));
    return res;
  }
}
