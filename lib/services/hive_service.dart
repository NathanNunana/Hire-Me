part of hireme_services;

abstract class HiveService {
  Future initBoxes();
  void clearPref();

  void persistToken(String token);
  String? retrieveToken();

  void persistProfile();
  // Profile retrieveProfile();
}

class HiveServiceImpl implements HiveService {
  @override
  Future initBoxes() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(ProfileAdapter());
      // TODO: register the other adapters
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  void clearPref() {
    // TODO: implement clear preferences
  }

  @override
  void persistToken(String token) {
    // TODO: implement persistToken
  }

  @override
  String? retrieveToken() {
    // TODO: implement retrieve token
  }

  @override
  void persistProfile() {
    // TODO: implement persist profile
  }
}
