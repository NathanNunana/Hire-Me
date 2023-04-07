part of hireme_utils;

class Singleton {
  static List<ChangeNotifierProvider> registerProvider() => [
        ChangeNotifierProvider(
          create: (_) => JobProvider(),
        ),
      ];
}
