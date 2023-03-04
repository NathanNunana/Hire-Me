part of hireme_utils;

class Singleton {
  static List<Provider> registerProvider() => [
        Provider<JobProvider>(create: (_) => JobProvider()),
      ];
}
