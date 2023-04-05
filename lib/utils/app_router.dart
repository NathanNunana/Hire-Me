part of hireme_utils;

class AppRouter {
  // routes
  static const String initRoute = "/";
  static const String homeRoute = "/home";
  static const String detailsRoute = "/details";
  static const String editProfile = "/editProfile";

  // handling generation of route
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        return _route(
          const SignIn(),
          initRoute,
        );
      case homeRoute:
        return _route(
          const LandingScreen(),
          homeRoute,
        );
      case detailsRoute:
        return _route(
          const JobDescription(),
          detailsRoute,
        );
      case editProfile:
        return _route(
          const EditProfile(),
          editProfile,
        );
      default:
        return _route(
            Scaffold(
              appBar: AppBar(
                title: const Text("Hire Me"),
              ),
              body: const Center(
                child: Text("Hire Me"),
              ),
            ),
            'unknown');
    }
  }

  // method handling page routing
  static Route<dynamic> _route(Widget screen, String route) {
    return CupertinoPageRoute<dynamic>(builder: (_) => screen);
  }
}
