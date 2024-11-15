part of hireme_utils;

class NetworkUtil {
  // bearer token
  static String? _getBearerToken() {
    return HiveServiceImpl().retrieveToken();
  }

  final String baseDomain = HiremeConfig.instance!.values.baseDomain;

  // Get Request
  Future getReq(String url) async {
    try {
      final response = await http.get(Uri.parse('$baseDomain/$url'));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  // TODO: make post requests to the internet
}
