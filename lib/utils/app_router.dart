part of hireme_utils;

class AppRouter {
  // routes
  static const String initRoute = "/";
  static const String homeRoute = "/home";
  static const String onboardingRoute = "/onboarding";
  static const String detailsRoute = "/details";
  static const String editProfile = "/editProfile";
  static const String submitRoute = "/submitRoute";
  static const String viewAllRoute = "/viewAll";
  static const String registerRoute = "/register";
  static const String signIn = "/signIn";

  // handling generation of route
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        return _route(const Loader());
      case signIn:
        return _route(const SignIn());
      case homeRoute:
        return _route(const LandingScreen());
      case onboardingRoute:
        return _route(const OnboardingScreen());
      case detailsRoute:
        return _route(const JobDescription());
      case editProfile:
        return _route(EditProfile());
      case viewAllRoute:
        return _route(const ViewAll());
      case registerRoute:
        return _route(const Register());
      case submitRoute:
        return _route(const SubmitApplication());
      default:
        return _route(const Loader());
    }
  }

  // method handling page routing
  static Route<dynamic> _route(Widget screen) {
    return CupertinoPageRoute<dynamic>(builder: (_) => screen);
  }
}
