abstract class BaseService {
  final String baseUrl = "https://tingla.pixer.uz/";

  Future<dynamic> postResponse(String url, {Map<String, String>? params, Object? body});

  Future<dynamic> getResponse(String url, {Map<String, String>? params});
}
