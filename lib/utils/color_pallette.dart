part of hireme_utils;

class AppTheme {
  // colors
  late Color bg1;
  late Color primary;
  late Color primary1;
  late Color primary2;
  late Color secondary;
  late Color accent;
  late Color accentDark;
  late Color txt;
  late Color accentTxt;
  late Color negativeTxt;

  // generate apptheme color based on brightness class
  static AppTheme appTheme(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? isDarkTheme()
          : isLightTheme();

  // dark theme colors
  static AppTheme isDarkTheme() {
    return AppTheme()
      ..bg1 = const Color(0xFFFFFFFF)
      ..primary = const Color(0xFFF3FCFF)
      ..primary1 = const Color(0xffF0FBFF)
      ..primary2 = const Color(0xffECFBFF)
      ..secondary = const Color(0xff0096FF)
      ..accent = const Color(0xff0378C9)
      ..accentDark = const Color(0xff0E7CC9)
      ..txt = const Color(0xff000000)
      ..accentTxt = const Color(0xff8C8C8C)
      ..negativeTxt = const Color(0xffFFFFFf);
  }

  // light theme colors
  static AppTheme isLightTheme() {
    return AppTheme()
      ..bg1 = const Color(0xffFFFFFF)
      ..primary = const Color(0xffF3FCFF)
      ..primary1 = const Color(0xffF0FBFF)
      ..primary2 = const Color(0xffECFBFF)
      ..secondary = const Color(0xff0096FF)
      ..accent = const Color(0xff0378C9)
      ..accentDark = const Color(0xff0E7CC9)
      ..txt = const Color(0xff000000)
      ..accentTxt = const Color(0xff8C8C8C)
      ..negativeTxt = const Color(0xffFFFFFF);
  }
}
