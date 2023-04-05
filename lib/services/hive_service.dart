part of hireme_services;

abstract class HiveService {
  Future initBoxes();
  void clearPref();

  void persistToken(String token);
  String? retrieveToken();

  void persistProfile(Profile profile);
  Profile? retrieveProfile();
}

class HiveServiceImpl implements HiveService {
  @override
  Future initBoxes() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(ProfileAdapter());
      // TODO: register the other adapters
      await Hive.openBox<dynamic>(HiremeConfig.instance!.values.authBox);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void clearPref() {
    try {
      Hive.box<dynamic>(HiremeConfig.instance!.values.authBox)
          .deleteAll(<String>[
        'accessToken',
        'profile',
      ]);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void persistToken(String token) {
    try {
      Hive.box<dynamic>(HiremeConfig.instance!.values.authBox)
          .put('accessToken', token);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  String? retrieveToken() {
    try {
      final box = Hive.box<dynamic>(HiremeConfig.instance!.values.authBox);
      return box.get('accessToken') as String?;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void persistProfile(Profile profile) {
    try {
      Hive.box<dynamic>(HiremeConfig.instance!.values.authBox)
          .put('newProfile', profile);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Profile? retrieveProfile() {
    try {
      final box = Hive.box<dynamic>(HiremeConfig.instance!.values.authBox);
      final profile = box.get('newProfile') as Profile?;
      if (profile == null) return null;
      return profile;
    } catch (e) {
      throw Exception(e);
    }
  }
}
