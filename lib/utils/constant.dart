part of hireme_utils;

class HiremeValues {
  HiremeValues({
    required this.baseDomain,
    required this.authBox,
  });

  final String baseDomain;
  final String authBox;
}

class HiremeConfig {
  factory HiremeConfig({required HiremeValues values}) {
    return _instance ??= HiremeConfig._internal(values);
  }

  HiremeConfig._internal(this.values);

  final HiremeValues values;
  static HiremeConfig? _instance;

  static HiremeConfig? get instance => _instance;
}
