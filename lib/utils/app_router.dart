part of hireme_utils;

class AppRouter {
  // routes
  static const String initRoute = "/";

  // handling generation of route
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        return _route(
          const HomeScreen(),
          initRoute,
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
